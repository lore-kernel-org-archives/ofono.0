Content-Type: multipart/mixed; boundary="===============8197731081118089189=="
MIME-Version: 1.0
From: =?unknown-8bit?b?5ZGo55C85ZGo55C8?= <zhouqiong.zq@alibaba-inc.com>
Subject: =?utf-8?q?=E7=AD=94=E5=A4=8D=3A_a_problem_about_ofono_dbus?=
Date: Sat, 10 Jan 2015 16:07:40 +0800
Message-ID: <002d01d02cac$810c5310$8324f930$@alibaba-inc.com>
In-Reply-To: <54AFEDAD.3090004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8197731081118089189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Denis:
   You are right, I found the root cause. Thanks a lot.

BR
Zhou qiong

-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
=E5=8F=91=E4=BB=B6=E4=BA=BA: Denis Kenzior [mailto:denkenz(a)gmail.com] =

=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2015=E5=B9=B41=E6=9C=889=E6=97=A5 23:=
03
=E6=94=B6=E4=BB=B6=E4=BA=BA: =E5=91=A8=E7=90=BC(=E5=91=A8=E7=90=BC); ofono(=
a)ofono.org
=E4=B8=BB=E9=A2=98: Re: a problem about ofono dbus

Hi,

On 01/09/2015 03:19 AM, =E5=91=A8=E7=90=BC(=E5=91=A8=E7=90=BC) wrote:
> Hi, all:
>
>     I have a problem when accessing ofono dbus interface, after run my =

> code, there is error =E2=80=9Cprocess 14234: type invalid 0 not a basic t=
ype =

> D-Bus not built with -rdynamic so unable to print a backtrace Aborted=E2=
=80=9D.
>
>     How to debug the issue? Would you please give some suggestion?
>

Most likely the message you are trying to send is invalid.

Regards,
-Denis


--===============8197731081118089189==--

