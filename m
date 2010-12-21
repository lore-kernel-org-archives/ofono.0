Content-Type: multipart/mixed; boundary="===============2037122716466917117=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2 1/2] stemodem: Create network interfaces statically
Date: Tue, 21 Dec 2010 06:38:39 -0800
Message-ID: <1292942319.2658.45.camel@aeonflux>
In-Reply-To: <1292449768-6060-2-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2037122716466917117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Changes:
> o Restructure code so interfaces are created statically when probe is cal=
led,
>   instead of creating interfaces dynamically at activation.
> o Changed debug messages.
> o Removed some of the unnecessary initializations at declaration.
> o No longer reporting "default gateway" for PtP IP Interface.
> o Bugfix: Handle network initiated deactivation.
> ---
>  drivers/stemodem/gprs-context.c |  149 +++++++++++++++++++++------------=
-----
>  1 files changed, 82 insertions(+), 67 deletions(-)

looks good to me now. Patch has been applied.

Regards

Marcel



--===============2037122716466917117==--

