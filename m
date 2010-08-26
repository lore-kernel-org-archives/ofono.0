Content-Type: multipart/mixed; boundary="===============3642069900069908337=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [sim-reset-pin PATCH 2/4] atmodem/sim: reset PIN or PIN2
Date: Thu, 26 Aug 2010 10:13:13 -0500
Message-ID: <4C768489.2030205@gmail.com>
In-Reply-To: <1282826957-8238-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3642069900069908337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 08/26/2010 07:49 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> The PIN or PIN2 reset requires that modem waits for corresponding PUK cod=
e.
> If PIN is unlocked, modem does not wait for PUK code. Modem does not wait
> for PUK2 by default. The modem is triggered into a state waiting for PUK
> codes with AT+CPWD command.
> =

> Password reset may fail if some other command is executed between AT+CPWD,
> AT+CPIN? and AT+CPIN.

Was this patch tested with modems other than mbm?

Regards,
-Denis

--===============3642069900069908337==--

