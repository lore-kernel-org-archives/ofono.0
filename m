Content-Type: multipart/mixed; boundary="===============3884090990769726785=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] voicecall API changes (proposal v3)
Date: Mon, 07 Feb 2011 10:38:42 -0600
Message-ID: <4D502012.4050704@gmail.com>
In-Reply-To: <3150a4f74efe520f7c0dc81da26b016739b28784.1297076002.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3884090990769726785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

> +		CallForwarded(string type)
> +
> +			Signal emitted when an outgoing voice call is made and
> +			the call has been redirected to another number due to
> +			the remote party's "Call Forwarding" Supplementary
> +			Services settings. In this case the type parameter in
> +			the signal is set to "outgoing".

You do not want to distinguish between conditional / unconditional?
Just checking here, either one is fine with me.

> +			The signal is also emitted when the incoming voice call
> +			is a redirected call due to a call forwarding operation.
> +			In this case the type parameter in the signal is set to
> +			"incoming".
> +
> +
>  Properties	array{string} EmergencyNumbers [readonly]
>  =

>  			Contains the list of emergency numbers recognized

The proposal looks good to me.  I'd apply it, however git am complains:

Applying: voicecall API changes (proposal v3)
/home/denkenz/ofono-master/.git/rebase-apply/patch:32: new blank line at
EOF.
+
fatal: 1 line adds whitespace errors.

Regards,
-Denis

--===============3884090990769726785==--

