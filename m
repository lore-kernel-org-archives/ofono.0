Content-Type: multipart/mixed; boundary="===============7602741736211235227=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: Clarification on USSD support in ofono
Date: Tue, 31 Aug 2010 18:48:06 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A0E1B9@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <4C7D1BEF.50800@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7602741736211235227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Denis,
 =

> The original USSD API actually did look like this.  It used binary
data
> + dcs field.  However, we quickly found that all modems are screwed up
> in this area.  The specification added binary PDU mode to SMS and CBS,
but never bothered with USSD.  So all modems get this part wrong.

> Currently about the best we can do is pass UTF8 around.  If you have a
modem that gets this part right, we'd like to hear about it.  If the
Send USSD proactive command is =

> not handled by the modem, then oFono will try to do its best.
However, we make no guarantees ;)

I think its better to send the dcs and the binary data to the atom
driver. If the modem doesn't support other than GSM 7-bit alphabet, then
the conversion can be done in the atom driver. This way it will be
general to any modem.

Let me know your views on this.

Regards,
jeevaka


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============7602741736211235227==--

