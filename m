Content-Type: multipart/mixed; boundary="===============4436825251285150131=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] SetProperty method and Powered property missing from
 modem-api doc.
Date: Mon, 19 Oct 2009 12:54:26 -0500
Message-ID: <200910191254.26955.denkenz@gmail.com>
In-Reply-To: <ae5fd6e50910190606m88b1ed9w2f7b1741ec4e01c@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4436825251285150131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

> SetProperty method and Powered Property where missing from modem-api.txt

I'm having trouble applying this patch.  Are you using a private repository=
 by =

any chance?

git am --3way ~/merge/\[PATCH\]\ SetProperty\ method\ and\ Powered\ propert=
y\ =

missing\ from\ modem-api\ doc =

Applying: SetProperty method and Powered property missing from modem-api do=
c.
error: patch failed: doc/modem-api.txt:12
error: doc/modem-api.txt: patch does not apply
Using index info to reconstruct a base tree...
error: patch failed: doc/modem-api.txt:12
error: doc/modem-api.txt: patch does not apply
Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Cannot fall back to three-way merge.
Patch failed at 0001 SetProperty method and Powered property missing from =

modem-api doc.
When you have resolved this problem run "git am -3 --resolved".
If you would prefer to skip this patch, instead run "git am -3 --skip".
To restore the original branch and stop patching run "git am -3 --abort".

>
> Question:
>
> I'm not sure if the "On success a PropertyChanged signal will be emitted."
> message is valid, as the PropertyChanged signal is sent only once when
> doing for example the following:

To be pedantic: a successful method invocation does mean that a =

PropertyChanged will be emitted.  PropertyChanged is emitted only when the =

property has actually changed.  Thus if the property is being set to its =

current value, oFono will not emit the signal (but return success to the =

caller)  However, the wording is probably OK since you generally set the =

property to something that is different.

Regards,
-Denis

--===============4436825251285150131==--

