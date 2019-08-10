Content-Type: multipart/mixed; boundary="===============8215535297170476789=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Motorola Droid 4 SMS sending
Date: Sun, 11 Aug 2019 01:14:04 +0200
Message-ID: <20190810231404.GA26417@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8215535297170476789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

Motorola Droid 4 runs packet protocol over serial... and its kernel
driver requires explicit "write()" boundaries at places where packet
boundaries should be.

So I can send SMS using low level g_at... functions (that are not
normally accessible), but not using g_at_chat_send().

If anyone has good idea for clean (or clean enough) solution, let me
know.

Best regards,
									Pavel

   snprintf(buf, sizeof(buf), "AT+GCMGS=3D\r");
   encode_hex_own_buf(pdu, pdu_len, 0, buf_pdu);

#if WANT_IT_BROKEN
        strcat(buf, buf_pdu+2);
        g_at_chat_send(data->send_chat, buf, none_prefix, NULL, data, NULL);
#else
        g_at_io_write(data->send_chat->parent->io, buf, strlen(buf));
 	g_at_io_write(data->send_chat->parent->io, buf_pdu, strlen(buf_pdu));
	g_io_channel_flush(data->send_chat->parent->io->channel, NULL);
#endif
			=

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============8215535297170476789==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsMVBUN3dBQ2drUU1PZndhcFhiK3ZMSEtRQ2JCMUZYdTE1SDc4ejdIMVgrTmFHMVkvcEoK
VWZzQW4xRkovUWx6Mkdzc3NNUHhUYkdKQk5nd0hjWloKPVlIeDQKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============8215535297170476789==--

