Content-Type: multipart/mixed; boundary="===============2307189115300583780=="
MIME-Version: 1.0
From: Martin Pitt <martin.pitt@ubuntu.com>
Subject: Re: [PATCH] Port ofono test scripts to also work with Python3
Date: Tue, 11 Mar 2014 17:43:13 +0100
Message-ID: <20140311164313.GI2647@piware.de>
In-Reply-To: <531F2CE6.7080906@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2307189115300583780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hey Denis,

Denis Kenzior [2014-03-11 10:33 -0500]:
> Could you submit these patches using git-send-email?  It would be
> way easier for me to reply with my comments.

Done now. First time I use it, I hope I didn't mess up anything.

> >>> print()
> ()
> >>>
> =

> This is probably not what you intended.

Indeed not, thanks for spotting. Changed to print('') now, which does
the same (and the right thing) with both Python 2 and 3. The new
git-send-email'ed patch already has this.

> Patches 2 and 3 seem to be just fine.  Couldn't apply because they
> depend on patch 1.

Yes, unfortunately they are quite intrusive :/

> >Patch 5 does the remaining bits (unicode and raw_input, and updating
> >hashbangs) and is currently *not* bilingual. If you want these scripts
> >to only work with Python 3 (which should be fine these days), it can
> >be applied (we already did that in the ofono-rilmodem branch[2]).
> >Otherwise, if you generally agree to doing this conversion I'm
> >happy to change it to a form where it works with both Python versions.
> >But that's more involved and it's work that I would only do after
> >getting your "yes, we'll take it" confirmation. :-)
> >
> =

> I'm okay moving to Python 3, but you might want to send this as an
> RFC to garner more feedback.

That patch is a lot smaller, so it can be applied independently of the
other four. What you mean with "send as RFC" other than sending it to
the ML for review?

Thanks,

Martin

-- =

Martin Pitt                        | http://www.piware.de
Ubuntu Developer (www.ubuntu.com)  | Debian Developer  (www.debian.org)

--===============2307189115300583780==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlRSWNCQUVC
Q0FBR0JRSlRIejBoQUFvSkVORk84VjJ2NFJOSHVYb1FBSjN3OENHak0vUXBlb0pNYllUSklLbVoK
dWZaZ01UUGtLUEVDb0ZMZ3hRUjc5aFdBbm00UzM5NXVEenBvaXJSMnZBQnlSQUh6YWZvcUkyN3Fa
NU1uQ1A1dAplQi9xbVRkbVZZNHdTdHFRbjlhOHR1Z0hRMjBXMHFRR0J1c29FYVJ4YXRWUjlUWkps
elh0L09vQnlIL0xkRDcxCjNPZ0F4Tk1YZndycUdyRTM0Z0hhcTBBNjl1ZU40WDl2VjMwZlBBa1FI
Q3RTTWY4WUZ5blUwbjFldm5VbHN6aDYKdGZuVHdUNEFhVitKQ3lVZVRaL2RuWUc3cTdReEdicUpF
QjVyYVV3WWV6c2krczFobFZCb3RZQjNFS1djcW9BbwpWMGNqQXNDTVAydW8rRnlWSDdjZXBma1Nv
QmZTTHNPVzZmRmJpVUliTDJMQ3ZJZFIzU1BWVDd2c0VrQWVGSXJlCmtHTHU5VWMwVnpIZ2d1RjNI
bWNjY1MzMXFDRXZpdnU3RU5hU0kxZnQvVmxjVXBrTUlDQ3loajZCd21YdUo0SDUKQUpVMUowYXkw
TGlTZ21OalRaN3hsKzZYMWxPUHVSSm9kSFAwaUlIUE1vaG41R3NQcFVFTllpTzJUdmNaUTZtdwpz
Qm9PSGlBaFltZnV6NTZxTUtPQk0xMDdlbEd0Z2Z2Y3Nqc0pGZGpBQVg2UVhWK0YxWStyL2RReVNq
MDQ4MVpDCnFHMjFQYXV6elZtV01QZFhkZXRhUFk5RFlQcldJZnJiTFBaQS9Vc0FKdGlCZldNM0tT
b2UwNy9IUTFWTUZnSEkKN0diSHN5REo3MXBmeHZQcjRDMFBtN3Y2bEdqREpBY2RqSHZja0hYSVly
NUpaaVVTUFl1R2hlK28xaktGZ2lQWgo0NVRHdGw1L0UyUExqSGh6VkNYdAo9OC9ZKwotLS0tLUVO
RCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============2307189115300583780==--

