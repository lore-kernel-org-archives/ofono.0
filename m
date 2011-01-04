Content-Type: multipart/mixed; boundary="===============7843090559326184654=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv4] stemodem: Fix for MT call not working when caller id is
 hidden.
Date: Tue, 04 Jan 2011 01:25:25 -0800
Message-ID: <1294133125.5852.77.camel@aeonflux>
In-Reply-To: <1294130524-3515-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7843090559326184654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

> In *ECAV, the number will not be included if caller id is hidden.
> Set it to an empty string in that case, and set number type to
> 128, unknown number type.
> ---
>  drivers/stemodem/voicecall.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)

patch has been applied.

Regards

Marcel



--===============7843090559326184654==--

