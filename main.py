from flask import Flask, render_template,request,session,redirect
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
import os
import math
from werkzeug import secure_filename

from datetime import datetime
import json


""" Here we try to do config the with the config.json file  """

with open("config.json",'r') as c:
     params=json.load(c)["params"]
local_Server=True

app = Flask(__name__)

app.secret_key = 'super-secret-key'

""" uploder file configuration here"""

app.config['UPLOAD_FOLDER']=params['upload_location']

""" here we try do use local host as well as production host """

if(local_Server):
    app.config["SQLALCHEMY_DATABASE_URI"] = params["local_uri"]
else:
    app.config["SQLALCHEMY_DATABASE_URI"] = params["prod_uri"]

""" here we config the mail send with my gamil SMTP to my gmail_account with decleare in the config.json file """
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params["gmail-user"],
    MAIL_PASSWORD = params["gmail-password"]
)
mail=Mail(app)

db = SQLAlchemy(app)

""" sno,Name,Email,P_no.,Msg,date """


class Contacts(db.Model):
    """ Class me jo variable bnayenge vo exctally same hoga database k variable name se..."""

    sno = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(80), unique=False, nullable=False)
    Email = db.Column(db.String(80), unique=False, nullable=False)
    P_no = db.Column(db.String(12), unique=False, nullable=False)
    Msg = db.Column(db.String(50), unique=False, nullable=False)
    date = db.Column(db.String, unique=False, nullable=True)

""" this class is make for the post in the blog page """

class Posts(db.Model):

    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), unique=False, nullable=False)
    sub_heading = db.Column(db.String(80), unique=False, nullable=False)
    slug = db.Column(db.String(80), unique=False, nullable=False)
    content = db.Column(db.String(12), unique=False, nullable=False)
    post_by = db.Column(db.String(12), unique=False, nullable=False)
    date = db.Column(db.String, unique=False, nullable=True)
    img_file=db.Column(db.String(80), unique=False, nullable=False)


@app.route('/')
def home():

    """
        Pagination logic of Older and Newer post
        ________________________________________
            first_page:
                pre="#"
                next=" page+1 "
            second_page:
                pre=" page-1 "
                next=" page+1 "
            last_page:
                pre=" page-1 "
                next=" # "

    """
    page=request.args.get('page')
    posts =Posts.query.filter_by().all()
    last=math.ceil(len(posts)/int(params['no_of_posts']))

    if(not str(page).isnumeric()):
        page=1
    page=int(page)
    posts= posts[(page-1)*int(params['no_of_posts']) : (page-1)*int(params['no_of_posts']) + int(params['no_of_posts'])]
    if (page==1):
        prev="#"
        next="/?page="+ str( page+1 )
    elif(page==last):
        prev="/?page="+ str( page-1 )
        next="#"
    else:
        prev="/?page="+ str( page-1)
        next="/?page="+ str( page+1 )





    return render_template('index.html',params=params,posts=posts,prev=prev,next=next)




@app.route('/about')
def about():
    return render_template('about.html',params=params)

@app.route('/dashbord',methods=['GET','POST'])
def dashbord():

    if "user" in session and session['user']==params['admin_user']:
        posts=Posts.query.all()
        return render_template("dashbord.html", params=params,posts=posts)
    if request.method=='POST':
        username=request.form.get('uname')
        userpass = request.form.get('pass')
        if(username==params['admin_user'] and userpass==params['admin_password']):
            session['user']=username
            posts = Posts.query.all()
            return render_template('dashbord.html',params=params,posts=posts)
        else:
            return render_template('login.html', params=params)
    else:
        return render_template('login.html',params=params)



@app.route('/edit/<string:sno>' , methods=['GET', 'POST'])
def edit(sno):
    if "user" in session and session['user']==params['admin_user']:
        if request.method=="POST":
            box_title=request.form.get('title')
            sub_title=request.form.get('sub_heading')
            slug=request.form.get('slug')
            content=request.form.get('content')
            post_by=request.form.get('post_by')
            img_file=request.form.get('img_file')
            date=datetime.now()

            if sno == '0':
                post= Posts(title=box_title, sub_heading=sub_title, slug=slug, content=content, post_by=post_by, img_file=img_file, date=date)
                db.session.add(post)
                db.session.commit()
                post = Posts.query.filter_by(sno=sno).first()
                return render_template('edit.html',params=params,sno=sno,post=post)

            else:
                post=Posts.query.filter_by(sno=sno).first()
                post.title= box_title
                post.sub_heading=sub_title
                post.slug=slug
                post.content=content
                post.post_by=post_by
                post.img_file=img_file
                post.date=date
                db.session.commit()
        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html',params=params,sno=sno,post=post)


""" Delete post deleting work from here """

@app.route('/delete/<string:sno>' , methods=['GET', 'POST'])
def delete(sno):
    if "user" in session and session['user']==params['admin_user']:
        post=Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashbord')




""" Uploader work from here """

@app.route('/uploader', methods=['GET','POST'])
def upload():
    if "user" in session and session['user']==params['admin_user']:
        if request.method=="POST":
            f=request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
            return render_template('uploaded.html',params=params)



""" uploaded successfully work form here"""

@app.route('/uploaded', methods=['GET','POST'])
def uploaded():
    return render_template('uploaded.html',params=params)



""" logout functioj work form here """


@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashbord')



@app.route('/post/<string:post_slug>',methods=['GET'])
def post_route(post_slug):
    post=Posts.query.filter_by(slug=post_slug).first()


    return render_template('post.html',params=params,post=post)



@app.route('/post')
def post():

    return render_template('post.html',params=params,post=post)



@app.route('/contact', methods=['GET','POST']) ## yha methods define krna jaruri hai 'GET' and 'POST' ka
def contact():
    """ yha ham html page se contact k variable ko fetch kr rhe hai"""
    if request.method=='POST':
        name=request.form.get('name')
        email=request.form.get('email')
        phone=request.form.get('phone')
        message=request.form.get('message')

        """ Ab yha se database me entry marenge """
        """ aur yha se database k variable ko contact k variable k equal krenge ki database data save ho sake  """
        """ aur LHS->DataBase 'var' and  RHS->Contact_Page 'var'  """
        """ sno,Name,Email,P_no.,Msg,date """

        entry=Contacts(Name=name,date=datetime.now(),Email=email,P_no=phone,Msg=message)
        """ yha se entery database me add hoga"""
        db.session.add(entry)
        db.session.commit()

        """  here we used the google smtp to send the message to our gmail account   """
        mail.send_message('New message from ' + name,
                          sender=email,
                          recipients=[params['gmail-user']],
                          body="Message -> " + message+ " \n"
                               " Contact-> " + phone + " \n "
                               "Email-> " + email,
                          )



    return render_template('contact.html',params=params)

if __name__ == '__main__':
    app.run(debug=True)