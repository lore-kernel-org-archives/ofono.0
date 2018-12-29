Content-Type: multipart/mixed; boundary="===============3167817779257128226=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Motorola motmdm support
Date: Sat, 29 Dec 2018 15:16:08 -0600
Message-ID: <e959006f-5f8d-8d25-b9d2-dbbcb6a5b073@gmail.com>
In-Reply-To: <20181229094953.GA15358@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3167817779257128226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 12/29/2018 03:49 AM, Pavel Machek wrote:
> Hi!
> =

> Motorola phones use "interesting" setup.
> =

> There's qmi and "normal" (but very buggy) AT interface on
> them. Unfortunately that uses USB and uses too much power (which is a
> problem on phone).
> =

> Plus there's /dev/motmdm1, motmdm3 and motmdm9, multiplexed over
> serial line.

Kernel 27.010 multiplexer or something else entirely?

> =

> It uses subset of AT commands (good) with slightly modified
> protocol... it says ":OK" instead of "OK" and puts ~ before
> unsolicited messages.

Funny

> =

> Other major difference is that commands need to be sent to the right
> device. It seems motmdm1 is for status and call control, and motmdm9
> is for incoming sms.
> =

> I guess that right way to do this is to introduce
> drivers/motorolamodem (or can we just have drivers/motorola?).
> =


For some weird historic reason we called the atom drivers and thus the =

subdirectory housing the relevant sources with the 'modem' suffix.  So I =

guess we should stick to that just to be consistent.

We can have a separate discussion on whether it makes sense to drop the =

'modem' suffix and what the implications are (probably none).  If we =

decide to drop the suffix, then we should/will do it for all drivers.

Regards,
-Denis

--===============3167817779257128226==--

