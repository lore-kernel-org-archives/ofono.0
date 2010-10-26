Content-Type: multipart/mixed; boundary="===============7753252096565968898=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] ifxmodem: Notify core about commands handled in modem.
Date: Wed, 27 Oct 2010 00:03:59 +0200
Message-ID: <1288130639.3613.26.camel@aeonflux>
In-Reply-To: <1288083128-24058-4-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7753252096565968898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> +	/*
> +	 * A proactive command starts with a Proactive UICC Command BER-TLV
> +	 * short tag (0xd0) with optional pad bytes, a Terminal Response
> +	 * starts with the Command Details CTLV tag (0x81).
> +	 */
> +	if (pdu[0] !=3D 0x81)
> +		ofono_stk_proactive_command_handled_notify(stk, len, pdu);
> +	else
> +		ofono_stk_terminal_response_sent_notify(stk, len, pdu);

why are we duplicating this in every driver? Can we just not give the
whole PDU back to core and let the core separate it?

Regards

Marcel



--===============7753252096565968898==--

