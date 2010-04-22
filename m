Content-Type: multipart/mixed; boundary="===============6412676554834685584=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ppp: implement MRU option
Date: Thu, 22 Apr 2010 15:16:58 -0500
Message-ID: <201004221516.58518.denkenz@gmail.com>
In-Reply-To: <1271888790-5046-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6412676554834685584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> @@ -80,7 +88,7 @@ static gboolean ppp_net_callback(GIOChannel *channel,
>  GIOCondition cond,
> =

>  	if (cond & G_IO_IN) {
>  		/* leave space to add PPP protocol field */
> -		status =3D g_io_channel_read_chars(channel, buf + 2, MAX_PACKET,
> +		status =3D g_io_channel_read_chars(channel, buf + 2, net->mtu,
>  				&bytes_read, &error);
>  		if (bytes_read > 0) {
>  			ppp->proto =3D htons(PPP_IP_PROTO);

So I actually have a concern here.  Quoting RFC 1332 Section 2.1:
"Exactly one IP packet is encapsulated in the Information field of PPP
   Data Link Layer frames where the Protocol field indicates type hex
   0021 (Internet Protocol)."

However, you're not changing the physical MTU of the TUN/TAP interface, so =
in =

effect you are mangling the packets that are larger than net->mtu.  These =

packets will most likely simply be discarded leading to lots of fun.

Comments?

Regards,
-Denis

--===============6412676554834685584==--

