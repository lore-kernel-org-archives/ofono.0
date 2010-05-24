Content-Type: multipart/mixed; boundary="===============4886888361778900146=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: How To Run the PhoneSIM and OFono
Date: Mon, 24 May 2010 16:19:22 +0300
Message-ID: <AANLkTimvJPUX5FJh-IqTIfZhIhDufPMiNOhM0tKCLCCT@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4886888361778900146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello ALL,

I had checked all the available archives for ofono to find how to run the
phone simulator. It looks like the information is either wrong or outdated.

I found the thread
http://lists.ofono.org/pipermail/ofono/2009-October/000490.html, where for
0.4 version, the steps to run ofono and phonesim are given. There are a
couple of more thread which give similar data.

But this is not working for me. I am using ubunto 9.10.

1) As per the thread i run the phonesim as below after enabling phonesim in
the modem.conf file:

root(a)arun-laptop:/home/arun# phonesim -p 12345 -gui data/moblin.xml

---------------------------------------------------------------------------=
------------------------------
I don't see any output from this command, i can see that the phonesim
process is running. I also don't know what data needs to be present in
moblin.xml.

2) When i try to run ofonod:

root(a)arun-laptop:/home/arun# ofonod -nd
Missing argument for -d
root(a)arun-laptop:/home/arun# ofonod -n
ofonod[3873]: oFono version 0.20

---------------------------------------------------------------------------=
-------------------------------------------------------
why is the d option not working? or is it really required to put the d
option?
where can i find a document on running ofonod and the options?

3) The third step from the thread also resulted in error:

root(a)arun-laptop:/home/arun# dbus-send --system --print-reply
--dest=3Dorg.ofono /phonesim0 org.ofono.Modem.SetProperty string:Powered
variant:boolean:true
Error org.freedesktop.DBus.Error.UnknownMethod: Method "SetProperty" with
signature "sv" on interface "org.ofono.Modem" doesn't exist
---------------------------------------------------------------------------=
-------------------------------------------------------

Could anyone help me in running the ofono and phonesim?

Regards
Arun

--===============4886888361778900146==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGVsbG8gQUxMLDxicj48YnI+SSBoYWQgY2hlY2tlZCBhbGwgdGhlIGF2YWlsYWJsZSBhcmNoaXZl
cyBmb3Igb2Zvbm8gdG8gZmluZCBob3cgdG8gcnVuIHRoZSBwaG9uZSBzaW11bGF0b3IuIEl0IGxv
b2tzIGxpa2UgdGhlIGluZm9ybWF0aW9uIGlzIGVpdGhlciB3cm9uZyBvciBvdXRkYXRlZC48YnI+
PGJyPkkgZm91bmQgdGhlIHRocmVhZCA8YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL3Bp
cGVybWFpbC9vZm9uby8yMDA5LU9jdG9iZXIvMDAwNDkwLmh0bWwiPmh0dHA6Ly9saXN0cy5vZm9u
by5vcmcvcGlwZXJtYWlsL29mb25vLzIwMDktT2N0b2Jlci8wMDA0OTAuaHRtbDwvYT4sIHdoZXJl
IGZvciAwLjQgdmVyc2lvbiwgdGhlIHN0ZXBzIHRvIHJ1biBvZm9ubyBhbmQgcGhvbmVzaW0gYXJl
IGdpdmVuLiBUaGVyZSBhcmUgYSBjb3VwbGUgb2YgbW9yZSB0aHJlYWQgd2hpY2ggZ2l2ZSBzaW1p
bGFyIGRhdGEuPGJyPgo8YnI+QnV0IHRoaXMgaXMgbm90IHdvcmtpbmcgZm9yIG1lLiBJIGFtIHVz
aW5nIHVidW50byA5LjEwLjxicj48YnI+MSkgQXMgcGVyIHRoZSB0aHJlYWQgaSBydW4gdGhlIHBo
b25lc2ltIGFzIGJlbG93IGFmdGVyIGVuYWJsaW5nIHBob25lc2ltIGluIHRoZSBtb2RlbS5jb25m
IGZpbGU6PGJyPjxicj5yb290QGFydW4tbGFwdG9wOi9ob21lL2FydW4jIHBob25lc2ltIC1wIDEy
MzQ1IC1ndWkgZGF0YS9tb2JsaW4ueG1sPGJyPgo8YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPkkgZG9uJiMzOTt0IHNlZSBhbnkgb3V0cHV0IGZy
b20gdGhpcyBjb21tYW5kLCBpIGNhbiBzZWUgdGhhdCB0aGUgcGhvbmVzaW0gcHJvY2VzcyBpcyBy
dW5uaW5nLiBJIGFsc28gZG9uJiMzOTt0IGtub3cgd2hhdCBkYXRhIG5lZWRzIHRvIGJlIHByZXNl
bnQgaW4gbW9ibGluLnhtbC4gPGJyPgo8YnI+MikgV2hlbiBpIHRyeSB0byBydW4gb2Zvbm9kOjxi
cj48YnI+cm9vdEBhcnVuLWxhcHRvcDovaG9tZS9hcnVuIyBvZm9ub2QgLW5kPGJyPk1pc3Npbmcg
YXJndW1lbnQgZm9yIC1kPGJyPnJvb3RAYXJ1bi1sYXB0b3A6L2hvbWUvYXJ1biMgb2Zvbm9kIC1u
PGJyPm9mb25vZFszODczXTogb0Zvbm8gdmVyc2lvbiAwLjIwPGJyPjxicj4tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tPGJyPgp3aHkgaXMgdGhlIGQgb3B0aW9uIG5vdCB3b3JraW5nPyBvciBpcyBpdCByZWFsbHkg
cmVxdWlyZWQgdG8gcHV0IHRoZSBkIG9wdGlvbj88YnI+d2hlcmUgY2FuIGkgZmluZCBhIGRvY3Vt
ZW50IG9uIHJ1bm5pbmcgb2Zvbm9kIGFuZCB0aGUgb3B0aW9ucz88YnI+PGJyPjMpIFRoZSB0aGly
ZCBzdGVwIGZyb20gdGhlIHRocmVhZCBhbHNvIHJlc3VsdGVkIGluIGVycm9yOjxicj48YnI+cm9v
dEBhcnVuLWxhcHRvcDovaG9tZS9hcnVuIyBkYnVzLXNlbmQgLS1zeXN0ZW0gLS1wcmludC1yZXBs
eSAtLWRlc3Q9b3JnLm9mb25vIC9waG9uZXNpbTAgb3JnLm9mb25vLk1vZGVtLlNldFByb3BlcnR5
IHN0cmluZzpQb3dlcmVkIHZhcmlhbnQ6Ym9vbGVhbjp0cnVlPGJyPgpFcnJvciBvcmcuZnJlZWRl
c2t0b3AuREJ1cy5FcnJvci5Vbmtub3duTWV0aG9kOiBNZXRob2QgJnF1b3Q7U2V0UHJvcGVydHkm
cXVvdDsgd2l0aCBzaWduYXR1cmUgJnF1b3Q7c3YmcXVvdDsgb24gaW50ZXJmYWNlICZxdW90O29y
Zy5vZm9uby5Nb2RlbSZxdW90OyBkb2VzbiYjMzk7dCBleGlzdDxicj4tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PGJyPgo8YnI+Q291bGQgYW55b25lIGhlbHAgbWUgaW4gcnVubmluZyB0aGUgb2Zvbm8gYW5kIHBo
b25lc2ltPzxicj48YnI+UmVnYXJkczxicj5BcnVuPGJyPjxicj48YnI+Cg==

--===============4886888361778900146==--

