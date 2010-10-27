Content-Type: multipart/mixed; boundary="===============5452637442539883347=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] calypsomodem: Notify core about commands handled in modem.
Date: Wed, 27 Oct 2010 12:27:23 -0500
Message-ID: <4CC860FB.50109@gmail.com>
In-Reply-To: <1288083128-24058-2-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5452637442539883347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>  	/*
> -	 * Proactive command has been handled by the modem.  Should
> -	 * the core be notified?  For now we just ignore it because
> -	 * we must not respond to the command.
> +	 * A proactive command starts with a Proactive UICC Command BER-TLV
> +	 * short tag (0xd0) with optional pad bytes, a Terminal Response
> +	 * starts with the Command Details CTLV tag (0x81).
>  	 */
> +	if (pdu[0] !=3D 0x81)
> +		ofono_stk_proactive_command_handled_notify(stk, len, pdu);
> +	else
> +		ofono_stk_terminal_response_sent_notify(stk, len, pdu);
>  }

I removed terminal_response_sent_notify from the API and took care of
this in the core.  I also went ahead and fixed up the three drivers in
question.  Can you double check that I didn't screw this up?

Thanks,
-Denis

--===============5452637442539883347==--

