Content-Type: multipart/mixed; boundary="===============0656713188235828601=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] stkutil: display text attributes as html
Date: Thu, 01 Jul 2010 11:30:07 -0500
Message-ID: <4C2CC28F.2000707@gmail.com>
In-Reply-To: <1277810534-25450-2-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0656713188235828601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> +
> +char *stk_text_to_html(char *text, int text_len,
> +				const unsigned char *attrs, int attrs_len)
> +{
> +	GString *string =3D g_string_sized_new(text_len + 1);
> +	int formats[257];  /* maximum number of chars in text + 1 */
> +	int pos =3D 0, i, j, attr, prev_attr;
> +	guint8 start, end, code, color, len, align;
> +
> +	/* we will need formatting at the position beyond the last char */
> +	for (i =3D 0; i <=3D text_len; i++)
> +		formats[i] =3D STK_TEXT_FORMAT_INIT;
> +

Please note that the same formatting can be used for EMS messages
(23.040).  These messages have a fairly large max-len (255 segments *
~153 characters)  I'd like to have this function useable for EMS
messages as well.

> +	i =3D 0;
> +
> +	while (i < attrs_len) {

Using a for loop would be nicer here

> +		start =3D attrs[i++];
> +		len =3D attrs[i++];
> +		code =3D attrs[i++];

You might want to be extra paranoid here that attrs_len is a multiple of 4.

> +
> +		if (i < attrs_len)
> +			color =3D attrs[i++];
> +		else
> +			color =3D 0;
> +
> +		if (len =3D=3D 0)
> +			end =3D text_len;
> +		else
> +			end =3D start + len;
> +
> +		/* sanity check values */
> +		if (start > end || end > text_len)
> +			continue;
> +
> +		/*
> +		 * if the alignment is the same as either the default
> +		 * or the last alignment used, don't set any alignment
> +		 * value.
> +		 */
> +		if (start =3D=3D 0)
> +			align =3D STK_DEFAULT_TEXT_ALIGNMENT;

Are attributes which do not contain start =3D 0 valid?  If so, you might
take extra care here.

> +		else {
> +			align =3D (formats[start -1] & 0xFF) &
> +					STK_TEXT_FORMAT_ALIGN_MASK;
> +			if (align =3D=3D STK_TEXT_FORMAT_NO_ALIGN)
> +				align =3D STK_DEFAULT_TEXT_ALIGNMENT;
> +		}
> +
> +		if ((code & STK_TEXT_FORMAT_ALIGN_MASK) =3D=3D align)
> +			code |=3D STK_TEXT_FORMAT_NO_ALIGN;
> +
> +		attr =3D code | (color << 8);
> +
> +		for (j =3D start; j < end; j++)
> +			formats[j] =3D attr;
> +	}
> +
> +	prev_attr =3D STK_TEXT_FORMAT_INIT;
> +
> +	while (pos <=3D text_len) {

A for loop would be more readable here in my opinion

> +		attr =3D formats[pos];
> +		if (attr !=3D prev_attr) {
> +			if (prev_attr !=3D STK_TEXT_FORMAT_INIT)
> +				end_format(string, prev_attr & 0xFF);
> +
> +			if (attr !=3D STK_TEXT_FORMAT_INIT)
> +				start_format(string, attr & 0xFF,
> +							(attr >> 8) & 0xFF);
> +
> +			prev_attr =3D attr;
> +		}
> +
> +		if (pos =3D=3D text_len)
> +			break;
> +
> +		switch (text[pos]) {
> +		case '\n':
> +			g_string_append(string, "<br/>");
> +			break;
> +		case '\r':
> +		{
> +			g_string_append(string, "<br/>");
> +			if ((pos + 1 < text_len) && (text[pos + 1] =3D=3D '\n'))
> +				pos++;
> +		}

Fallthrough on purpose?

> +		case '<':
> +			g_string_append(string, "&lt;");
> +			break;
> +		case '>':
> +			g_string_append(string, "&gt;");
> +			break;
> +		case '&':
> +			g_string_append(string, "&amp;");
> +			break;
> +		default:
> +			g_string_append_c(string, text[pos]);
> +		}
> +		pos++;
> +	}
> +
> +	/* return characters from string. Caller must free char data */
> +	return g_string_free(string, FALSE);
> +}
> diff --git a/src/stkutil.h b/src/stkutil.h
> index ca4817e..5b3a679 100644
> --- a/src/stkutil.h
> +++ b/src/stkutil.h
> @@ -1635,6 +1635,27 @@ struct stk_envelope {
>  	};
>  };
>  =

> +#define STK_TEXT_FORMAT_ALIGN_MASK 0x03
> +#define STK_TEXT_FORMAT_FONT_MASK 0x0C
> +#define STK_TEXT_FORMAT_STYLE_MASK 0xF0
> +#define STK_DEFAULT_TEXT_ALIGNMENT 0x00
> +#define STK_TEXT_FORMAT_INIT -1
> +
> +/* Defined in ETSI 123 40 9.2.3.24.10.1.1 */
> +enum stk_text_format_code {
> +	STK_TEXT_FORMAT_LEFT_ALIGN =3D 0x00,
> +	STK_TEXT_FORMAT_CENTER_ALIGN =3D 0x01,
> +	STK_TEXT_FORMAT_RIGHT_ALIGN =3D 0x02,
> +	STK_TEXT_FORMAT_NO_ALIGN =3D 0x03,
> +	STK_TEXT_FORMAT_FONT_SIZE_LARGE =3D 0x04,
> +	STK_TEXT_FORMAT_FONT_SIZE_SMALL =3D 0x08,
> +	STK_TEXT_FORMAT_FONT_SIZE_RESERVED =3D 0x0c,
> +	STK_TEXT_FORMAT_STYLE_BOLD =3D 0x10,
> +	STK_TEXT_FORMAT_STYLE_ITALIC =3D 0x20,
> +	STK_TEXT_FORMAT_STYLE_UNDERLINED =3D 0x40,
> +	STK_TEXT_FORMAT_STYLE_STRIKETHROUGH =3D 0x80,
> +};
> +

All of these enums really belong in the .c file.  There is no other
client which can make use of them.

>  struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
>  						unsigned int len);
>  void stk_command_free(struct stk_command *command);
> @@ -1643,3 +1664,5 @@ const unsigned char *stk_pdu_from_response(const st=
ruct stk_response *response,
>  						unsigned int *out_length);
>  const unsigned char *stk_pdu_from_envelope(const struct stk_envelope *en=
velope,
>  						unsigned int *out_length);
> +char *stk_text_to_html(char *text, int text_len,
> +				const unsigned char *attrs, int attrs_len);

Why not const char *text?

Regards,
-Denis

--===============0656713188235828601==--

