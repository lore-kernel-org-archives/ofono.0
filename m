Content-Type: multipart/mixed; boundary="===============1679806538436133665=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 1/2] voicecall: document voicecall driver methods
Date: Wed, 20 Oct 2010 12:55:37 -0500
Message-ID: <4CBF2D19.8020105@gmail.com>
In-Reply-To: <1287594028-29970-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1679806538436133665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> +	/*
> +	 * Release active, alerting, dialing, or incoming calls
> +	 * and answer the waiting call.
> +	 */

This actually only affects active calls.  On AT modems you cannot have
waiting calls when dialing / alerting.  Dialing / Alerting / Incoming
are also never affected by any CHLD commands.

I pushed my own patch with the updated documentation.  Let me know if I
missed something.

Regards,
-Denis

--===============1679806538436133665==--

