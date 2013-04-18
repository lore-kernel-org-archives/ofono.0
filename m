Content-Type: multipart/mixed; boundary="===============8346815413431166343=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 3/7] hfp_ag_bluez5: Remove fd from hash when disconnect
Date: Thu, 18 Apr 2013 08:53:03 -0500
Message-ID: <516FFABF.8020706@gmail.com>
In-Reply-To: <1366062110-28031-4-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8346815413431166343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

On 04/15/2013 04:41 PM, Paulo Borges wrote:
> When a RequestDisconnect() is received, the file descriptor must be
> closed. This way, the related emulator will be freed.

Actually you need to call shutdown() on it.  When multiple references to =

the file descriptor exist, close() simply deletes a reference.  It does =

not close the actual socket.

>
> But the emulator can also be disconnected automatically if its
> GAtServer closes. In this case, the hash will hold an invalid file
> descriptor.
>
> So, after the emulator is registered, we watch for G_IO_HUP in
> the corresponding file descriptor. If this condition happens, we
> can safely remove the file descriptor from the hash.

Overall I like this approach much better than the previous one.  I'd =

still re-arrange the patch set as follows:

- init/free hash table (same as patch 1)
- G_IO_HUP changes
- RequestDisconnect implementation

> ---
>   plugins/hfp_ag_bluez5.c |   43 ++++++++++++++++++++++++++++++++++++++++=
---
>   1 file changed, 40 insertions(+), 3 deletions(-)
>

Regards,
-Denis

--===============8346815413431166343==--

