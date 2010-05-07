Content-Type: multipart/mixed; boundary="===============8625412526479587842=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Fri, 07 May 2010 15:52:24 +0530
Message-ID: <COL106-W38605426EE0293974195DCF6F60@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8625412526479587842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi All,

Any body who is working ofono-phonesim suggest how to start ofono-phonesim =
simulator?

I installed ofono-phonesim from synaptic package manager in ubuntu lucid (1=
0.04) and i am trying start the simulator with the following ...

1. I modified modem.conf file with following content...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[phonesim]
Driver=3Dphonesim
Address=3D127.0.0.1
Port=3D12345
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

2. phonesim -p 12345  -gui ~/data/moblin.xml (i created data file in user h=
ome directory and placed moblin.xml file inside data)

But it is not displaying anything on the screen. But if i check with "ps ax=
 | grep phonesim" I am getting below o/p.

 5822 pts/1    S+     0:00 phonesim -p 12345 -gui /home/kandukis/data/mobli=
n.xml
 5842 pts/2    S+     0:00 grep --color=3Dauto phonesim

What is the problem and why simulator is not visible?

Please correct me if i am doing wrong...

Thanks and Regards,
Krishna.

 		 	   		  =

_________________________________________________________________
South Cinema This Decade
http://entertainment.in.msn.com/southcinemathisdecade/

--===============8625412526479587842==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KSGkg
QWxsLDxicj48YnI+QW55IGJvZHkgd2hvIGlzIHdvcmtpbmcgb2Zvbm8tcGhvbmVzaW0gc3VnZ2Vz
dCBob3cgdG8gc3RhcnQgb2Zvbm8tcGhvbmVzaW0gc2ltdWxhdG9yPzxicj48YnI+SSBpbnN0YWxs
ZWQgb2Zvbm8tcGhvbmVzaW0gZnJvbSBzeW5hcHRpYyBwYWNrYWdlIG1hbmFnZXIgaW48Yj4gdWJ1
bnR1IGx1Y2lkPC9iPiAoMTAuMDQpIGFuZCBpIGFtIHRyeWluZyBzdGFydCB0aGUgc2ltdWxhdG9y
IHdpdGggdGhlIGZvbGxvd2luZyAuLi48YnI+PGJyPjxmb250IHN0eWxlPSIiIGNvbG9yPSIjNGY4
MWJkIj48Yj4xLjwvYj48L2ZvbnQ+IEkgbW9kaWZpZWQgbW9kZW0uY29uZiBmaWxlIHdpdGggZm9s
bG93aW5nIGNvbnRlbnQuLi48YnI+PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTxi
cj48cHJlPjxpPltwaG9uZXNpbV08YnI+PC9pPjxpPkRyaXZlcj1waG9uZXNpbTxicj48L2k+PGk+
QWRkcmVzcz0xMjcuMC4wLjE8YnI+PC9pPjxpPlBvcnQ9MTIzNDU8YnI+PC9pPjwvcHJlPj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08YnI+PGJyPjxmb250IHN0eWxlPSIiIGNvbG9y
PSIjMWY0OTdkIj48Yj4yLjwvYj48L2ZvbnQ+IHBob25lc2ltIC1wIDEyMzQ1Jm5ic3A7IC1ndWkg
fi9kYXRhL21vYmxpbi54bWwgKGkgY3JlYXRlZCBkYXRhIGZpbGUgaW4gdXNlciBob21lIGRpcmVj
dG9yeSBhbmQgcGxhY2VkIG1vYmxpbi54bWwgZmlsZSBpbnNpZGUgZGF0YSk8YnI+PGJyPkJ1dCBp
dCBpcyBub3QgZGlzcGxheWluZyBhbnl0aGluZyBvbiB0aGUgc2NyZWVuLiBCdXQgaWYgaSBjaGVj
ayB3aXRoICI8Yj5wcyBheCB8IGdyZXAgcGhvbmVzaW08L2I+IiBJIGFtIGdldHRpbmcgYmVsb3cg
by9wLjxicj48YnI+Jm5ic3A7NTgyMiBwdHMvMSZuYnNwOyZuYnNwOyZuYnNwOyBTKyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyAwOjAwIHBob25lc2ltIC1wIDEyMzQ1IC1ndWkgL2hvbWUva2FuZHVr
aXMvZGF0YS9tb2JsaW4ueG1sPGJyPiZuYnNwOzU4NDIgcHRzLzImbmJzcDsmbmJzcDsmbmJzcDsg
UysmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgMDowMCBncmVwIC0tY29sb3I9YXV0byBwaG9uZXNp
bTxicj48YnI+V2hhdCBpcyB0aGUgcHJvYmxlbSBhbmQgd2h5IHNpbXVsYXRvciBpcyBub3Qgdmlz
aWJsZT88YnI+PGJyPlBsZWFzZSBjb3JyZWN0IG1lIGlmIGkgYW0gZG9pbmcgd3JvbmcuLi48YnI+
PGJyPlRoYW5rcyBhbmQgUmVnYXJkcyw8YnI+S3Jpc2huYS48YnI+PGJyPiAJCSAJICAgCQkgIDxi
ciAvPjxociAvPlRoZSBsYXRlc3QgYXV0byBsYXVuY2hlcyBhbmQgdGVzdCBkcml2ZXMgPGEgaHJl
Zj0naHR0cDovL2F1dG9zLmluLm1zbi5jb20vJyB0YXJnZXQ9J19uZXcnPkRyYWcgbicgZHJvcDwv
YT48L2JvZHk+CjwvaHRtbD4=
--===============8625412526479587842==--

