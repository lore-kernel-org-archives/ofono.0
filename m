Content-Type: multipart/mixed; boundary="===============8206567580211634494=="
MIME-Version: 1.0
From: Jens Rehsack <jr_extern@vfnet.de>
Subject: Re: [PATCH] add some length verification to avoid reading not owned
 memory
Date: Tue, 28 Feb 2012 09:30:17 +0100
Message-ID: <4F4C9099.7070609@vfnet.de>
In-Reply-To: <1330363339.3392.52.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8206567580211634494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Am 27.02.2012 18:22, schrieb Marcel Holtmann:
> Hi Jens,

Hi Marcel,

>> while reading mmsd sources I stumbled over missing length
>> checks in src/push.c:mms_push_notify(). I didn't re-read
>> the entire source to prove overall ;)
> =

> please use git format-patch and git send-email to send us inline
> patches. In case your email client doesn't support inline patches
> nicely.

Well, inline patches aren't requested at
http://ofono.org/wiki/ofono-etiquette. You probably should do.

> Reviewing patches that are attached is super painful and in most
> cases they get ignored then.

Well, my mail client (Thunderbird) and most modern clients I
know are able to show attached files of text/x-patch (and
similar) type. OTOH I wonder why you want to review patches
in your mail client. Wouldn't it much better to use a
specialized too which highlights the changes like
$ gvim "+vert diffpatch <patchfile>" <originalfile>
$ emacs
or
$ xfdiff ?
Don't you have to save the patch files in such cases anyway?

Best regards,
Jens

--===============8206567580211634494==--

