Content-Type: multipart/mixed; boundary="===============0137736964070638980=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] When setting the serial port,
 the previous settings need to be preserved.
Date: Mon, 19 Oct 2009 12:32:45 -0500
Message-ID: <200910191232.45844.denkenz@gmail.com>
In-Reply-To: <632f5f310910190728l2256681es4f8627b179d1ec84@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0137736964070638980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

> This took a while to locate. Shouldn't it be possible to use stty
> outside the daemon, and then daemon would just continue as usual?
>
> In my case, the cread was being removed, so no input data could be read.

Sorry but the patch is wrong, since you're blowing away all options that ha=
ve =

been set via the GHashTable.

GAtTty is really a convenience method, if you need something specific, pass=
 the =

option in the GHashTable or setup the fd however you wish by yourself.

Regards,
-Denis

--===============0137736964070638980==--

