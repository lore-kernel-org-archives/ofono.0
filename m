Content-Type: multipart/mixed; boundary="===============3245211962344033984=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Altered the atgeneric modem to include the added
 modem.conf options.
Date: Thu, 29 Oct 2009 11:25:06 -0500
Message-ID: <200910291125.06961.denkenz@gmail.com>
In-Reply-To: <632f5f310910270555r653f80b0m7b0009991664f55b@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3245211962344033984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

> The modem.conf options for the driver portion of the patch.

Patch has been applied with some refactoring afterward.  I know you ran =

checkpatch.pl, but please make sure you follow the coding standard even for =

parts which checkpatch.pl does not catch.  In particular:

> +static const char *tty_opts[] =3D
> +  {
> +	  "Baud",
> +	  "Read",
> +	  "Local",
> +	  "StopBits",
> +	  "DataBits",
> +	  "Parity",
> +	  "XonXoff",
> +	  "Rtscts",
> +	  NULL,
> +  };

- There are spaces for indentation, ONLY tabs should be used.
- The opening brace should be on the tty_opts line.


--===============3245211962344033984==--

