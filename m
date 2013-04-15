Content-Type: multipart/mixed; boundary="===============1508825059181281237=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/7] hfp_ag_bluez5: Remove emulator when disconnect
Date: Mon, 15 Apr 2013 07:30:47 -0500
Message-ID: <516BF2F7.50508@gmail.com>
In-Reply-To: <1365799265-19946-8-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1508825059181281237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

On 04/12/2013 03:41 PM, Paulo Borges wrote:
> When a RequestDisconnect() is received, the emulator must be both
> disconnected and removed from the hash.
>
> But an emulator can also be disconnected and freed automatically if its
> GAtServer closes. In this case, the hash can hold an invalid pointer.
>
> So, after the emulator is registered, a function is set to be called
> when the emulator is about to be freed and this function removes the
> emulator from the hash.
> ---
>   plugins/hfp_ag_bluez5.c |   43 +++++++++++++++++++++++++++++++++++++++-=
---
>   1 file changed, 39 insertions(+), 4 deletions(-)

Have you considered keeping track of the file descriptors instead?  e.g. =

simply adding a hash table of fds obtained from NewConnection() and =

g_io_add_watch()-ing on the 'HUP' condition?

Regards,
-Denis

--===============1508825059181281237==--

