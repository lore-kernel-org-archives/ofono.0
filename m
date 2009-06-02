Content-Type: multipart/mixed; boundary="===============5036523802560061776=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: add a common exit function for interfaces when manager_free and
 manager_destroy function is called
Date: Tue, 02 Jun 2009 17:39:13 -0500
Message-ID: <200906021739.14362.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5036523802560061776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Minjun,

On Tuesday 02 June 2009 02:02:29 Li, Minjun wrote:
> Hi Folks,
> I regenerated the patch.
> Because I found that manager_destroy function is lack of some exit functi=
on
> calls comparing to manager_free function, I add a common exit function for
> interfaces when manager_free and manager_destroy function is called.
>

In interface_exit: Please remove if (at)  block, its pointless.

Please get rid of all mode changes, only submit changes to files that are =

relevant to the fix.

Get a proper commit message.  E.g. put the description in the email into th=
e =

commit message.  =


> Best Regards,
> Minjun

Regards,
-Denis



--===============5036523802560061776==--

