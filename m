Content-Type: multipart/mixed; boundary="===============9145779752323211527=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] stkutil: add missing text and icon check
Date: Tue, 04 Jan 2011 10:43:33 -0600
Message-ID: <4D234E35.8070109@gmail.com>
In-Reply-To: <1293798647-4256-3-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9145779752323211527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 12/31/2010 06:30 AM, Jeevaka Badrappan wrote:
> As per the ETSI TS 102 223 section 6.5.4,
> If the terminalreceives an icon, and
> either an empty or no alpha identifier/text
> string is given by the UICC, than the terminal
> shall reject the command with general result
> "Command data not understood by terminal".
> ---
>  src/stkutil.c |  187 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 files changed, 171 insertions(+), 16 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index 8aee8f7..28d0a86 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -74,6 +74,14 @@ struct gsm_sms_tpdu {
>  	unsigned char tpdu[184];
>  };
>  =

> +static gboolean check_text_and_icon( const char *in, const unsigned char=
 icon_id)

Why is there a space before const char?

> +{
> +	if ((in =3D=3D NULL || strlen(in) < 1) && icon_id !=3D 0)

Can in ever be null?  And I'd also prefer not using strlen(in) but using
in[0] =3D=3D '\0'.

> +		return FALSE;
> +
> +	return TRUE;
> +}
> +
>  static char *decode_text(unsigned char dcs, int len, const unsigned char=
 *data)
>  {
>  	char *utf8;
> @@ -2383,6 +2391,7 @@ static enum stk_command_parse_result parse_display_=
text(
>  					struct comprehension_tlv_iter *iter)
>  {
>  	struct stk_command_display_text *obj =3D &command->display_text;
> +	enum stk_command_parse_result result;
>  =

>  	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
>  		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
> @@ -2392,7 +2401,7 @@ static enum stk_command_parse_result parse_display_=
text(
>  =

>  	command->destructor =3D destroy_display_text;
>  =

> -	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
> +	result =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
>  				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
>  				&obj->text,
>  				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
> @@ -2406,6 +2415,14 @@ static enum stk_command_parse_result parse_display=
_text(
>  				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
>  				&obj->frame_id,
>  				STK_DATA_OBJECT_TYPE_INVALID);
> +
> +	if (result !=3D STK_PARSE_RESULT_OK)
> +		return result;
> +
> +	if (check_text_and_icon(obj->text, obj->icon_id.id) =3D=3D FALSE)
> +		result =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
> +
> +	return result;
>  }
>  =


Since the following code is repeated ad-naseum, I'd like to see this as
a macro.  See e.g. CALLBACK_END macro in src/stkagent.c

Regards,
-Denis

--===============9145779752323211527==--

