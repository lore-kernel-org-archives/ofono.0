Content-Type: multipart/mixed; boundary="===============5711916624495474874=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] add some length verification to avoid reading not owned
 memory
Date: Mon, 27 Feb 2012 20:38:11 -0600
Message-ID: <4F4C3E13.40906@gmail.com>
In-Reply-To: <4F4C9099.7070609@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5711916624495474874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

> Well, my mail client (Thunderbird) and most modern clients I
> know are able to show attached files of text/x-patch (and
> similar) type. OTOH I wonder why you want to review patches
> in your mail client. Wouldn't it much better to use a

It is not that we read patches in the mail client, but that is also
useful.  The main use-case is to be able to easily comment on the patch
if changes are required.  And for that we require patches to be sent inline.

> specialized too which highlights the changes like
> $ gvim "+vert diffpatch <patchfile>" <originalfile>
> $ emacs
> or
> $ xfdiff ?
> Don't you have to save the patch files in such cases anyway?
> =


No, the typical workflow (at least for me) is to

- 'Save Email'
- vim email
- if looks okay, git am and compile test

Regards,
-Denis


--===============5711916624495474874==--

