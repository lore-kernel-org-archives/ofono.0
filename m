Content-Type: multipart/mixed; boundary="===============5962098279100312898=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: Re: [PATCH v2] add call-list helper to manage voice call lists
Date: Tue, 08 Aug 2017 14:23:28 +0200
Message-ID: <20170808142328.14bb9337@lazus.yip>
In-Reply-To: <29b777b7-d952-ad62-3171-6ce718b1ca88@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5962098279100312898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Aug 2017 12:42:55 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

Hi Dennis,

> So this is not in line with our patch submission guidelines.  See
> HACKING...
I'm sorry. I missed that one. Hopefully I got the coding style right so
far.

> We are not exposing glib into the oFono plugin API.  So the use of =

> GSList, etc data structures across driver <-> core boundary is not =

> possible.  The reasons are somewhat historic, but essentially
> non-GLib based plugins must be possible.  Also, oFono's use of GLib
> will be replaced by ell [1] in the future.
Interesting. Do you have any plans when and how the migratation will
be done?

> I'm still not quite sure what you're trying to solve with these
> changes? A bit more info on the motivation of the patches in the
> commit description would be helpful...

My motivation is to get rid of the generic part in the
modem drivers. E.g. look at the rild and atmodem, they have a lot
similiar code when parsing the call list.

So it would be nice to replace those. On the other side I've written a
voicecall driver for qmi which is using the call list, but I'm still
testing it.

Best,
Alex

PS. I better had tagged this patch RFC...
-- =

Alexander Couzens

mail: lynxis(a)fe80.eu
jabber: lynxis(a)fe80.eu
mobile: +4915123277221
gpg: 390D CF78 8BF9 AA50 4F8F  F1E2 C29E 9DA6 A0DF 8604

--===============5962098279100312898==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.sig"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUVCQ2dBZEZpRUVPUTNQZUl2NXFs
QlBqL0hpd3A2ZHBxRGZoZ1FGQWxtSnJVQUFDZ2tRd3A2ZHBxRGYKaGdTVnRBLzlIdkxidnA4RE1H
VlF5YUVrZkRlMUZHNE1ZSTJLeXJBbVE4d20xcDJOWm80b2NyZUxDOVh5QjM2SgpsRUROLzhkU1VY
RWxkOCtZQXBzQ3E2Q2VqOE5aYU95emFWU1F4Y1h4T1I0ck5LWXdYVVd4RStydmpNajY3ZzNhCjJV
VkxLbFFLZkdXZzljcTdYRnlheDVVYi9SSUIzYnpYeTlnRTlZdHpKWXExQ1l5SGRuZzVtRUIweis3
UUFHY2oKK3FpSVBDVFVCd0JCdzZKcVdKSUoyV1ZjY3p4S3dIckQzRWM3ZkRFT3pqMUpMTjVJdjRz
N3ZiejdlUjdIQndBeQpIVTJZQm1PLzY0SU9wZnJacVdxVklmMlVMRjEzY0ZvZ1MvbHRFME5LaEpt
dUx4dXlVYUduSGdtWXZkR0VHaEtvCmhtcWVmNXJ2VTRYN0NxYnY4L1haL09sb3JTN2FQQk5rVUgz
YjdJVFhvWWg5anJnVm9PY2taOTRCUWxtd2loR0EKY0k3akhuV01PRkJYRkFwL0x3SUkxRXdQVXpz
S3NSeHExNUJtTDlwZEt5SEdQR0U5TFAybXJiWEEvNGt5WWNMaApWREFLWktnTzk4NTI1Vk1Eb3hF
NjJ4dS9oSkhleU1Qb2sxTmtHSmlrUEk0UDA0ZUgyaE55YVZDU3lHWHQ3TDVsClh5Q1ZGd3ZKbGxV
bTRsZVBCcXBzWXdYZ1ZucklManlGeUdxSm5pT1k4WWIxZU1iYkRyRE56VkRpUWJNUm5hTEsKUFVn
OWZ0T3hZcW1YN0ZMcVhZczRUOFBCek5BTnhoU01CWDlHaDJZanBDamFucEhoNnpxa0FTYXVrNjFl
MEt0Uwp3Qy92aE85Ynh1V2xvQTFIbitVVW9GUlhJM0RpZDFFYXFLb1Z2SHFXeExVUVNwTWJnSWc9
Cj1xTHl4Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============5962098279100312898==--

