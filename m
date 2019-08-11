Content-Type: multipart/mixed; boundary="===============7050823104402115009=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Motorola Droid 4 SMS sending
Date: Sun, 11 Aug 2019 09:25:40 -0500
Message-ID: <9c4395ca-dd5c-ae90-f074-003541fc0ab2@gmail.com>
In-Reply-To: <20190810231404.GA26417@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7050823104402115009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 8/10/19 6:14 PM, Pavel Machek wrote:
> Hi!
> =

> Motorola Droid 4 runs packet protocol over serial... and its kernel
> driver requires explicit "write()" boundaries at places where packet
> boundaries should be.
> =

> So I can send SMS using low level g_at... functions (that are not
> normally accessible), but not using g_at_chat_send().
> =

> If anyone has good idea for clean (or clean enough) solution, let me
> know.
> =

> Best regards,
> 									Pavel
> =

>     snprintf(buf, sizeof(buf), "AT+GCMGS=3D\r");
>     encode_hex_own_buf(pdu, pdu_len, 0, buf_pdu);
> =


So speaking from memory, but 27.005 expects CMGS to be a two part =

command.  First you send AT+CMGS=3D<whatever> and the modem then prompts =

for the PDU using '>'.  Then we provide the PDU followed by Ctrl-Z.  If =

the Motorola modem doesn't do this, then you're stuck providing a full =

Motorola-Hacked-AT-Commands implementation of your own.

You can try hacking GAtChat to add a bunch of behavior-modifications =

like this, but I imagine that this protocol is different enough where =

such changes become a nightmare to keep track of.

Regards,
-Denis

--===============7050823104402115009==--

