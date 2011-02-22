Content-Type: multipart/mixed; boundary="===============0723164219727034620=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] Add CNAP support (callerid name presentation) to isimodem
Date: Tue, 22 Feb 2011 18:22:24 -0300
Message-ID: <20110222212224.GD2249@joana>
In-Reply-To: <1298403084-6119-1-git-send-email-a.reversat@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0723164219727034620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antoine,

* Antoine Reversat <a.reversat@gmail.com> [2011-02-22 14:31:24 -0500]:

> ---
>  drivers/isimodem/voicecall.c |   39 ++++++++++++++++++++++++++++++++++++=
++-
>  src/voicecall.c              |    4 ++--
>  2 files changed, 40 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
> index 0a32f27..e778f23 100644
> --- a/drivers/isimodem/voicecall.c
> +++ b/drivers/isimodem/voicecall.c
> @@ -56,8 +56,10 @@ struct isi_call {
>  	uint8_t cause;
>  	uint8_t addr_type;
>  	uint8_t presentation;
> +	uint8_t name_presentation;
>  	uint8_t reason;
>  	char address[20];
> +	char name[20];
>  	char addr_pad[4];
>  };
>  =

> @@ -231,6 +233,7 @@ static void isi_call_origin_address_sb_proc(struct is=
i_voicecall *ivc,
>  		isi_call_any_address_sb_proc(ivc, call, sb);
>  }
>  =

> +

Unrelated change here. Please remove.

>  static void isi_call_destination_address_sb_proc(struct isi_voicecall *i=
vc,
>  							struct isi_call *call,
>  							GIsiSubBlockIter *sb)
> @@ -239,6 +242,29 @@ static void isi_call_destination_address_sb_proc(str=
uct isi_voicecall *ivc,
>  		isi_call_any_address_sb_proc(ivc, call, sb);
>  }
>  =

> +static void isi_call_origin_info_sb_proc(struct isi_voicecall *ivc,
> +						struct isi_call *call,
> +						GIsiSubBlockIter *sb)
> +{
> +	uint8_t pres;
> +	uint8_t id;
> +	uint8_t len;
> +	char *name;
> +    =


Spaces here.

> +	if (!g_isi_sb_iter_get_byte(sb, &pres, 2) ||
> +			!g_isi_sb_iter_get_byte(sb, &id, 6) ||
> +			!g_isi_sb_iter_get_byte(sb, &len, 7) ||
> +			!g_isi_sb_iter_get_alpha_tag(sb, &name, 2 * len, 8))
> +		return;


Isn't this better:

	if (!g_isi_sb_iter_get_byte())
		return;
	if (!g_isi_sb_iter_get_byte())
		return;
	if (!g_isi_sb_iter_get_byte())
		return;
	if (!g_isi_sb_iter_get_alpha_tag())
		return;

> +    =


spaces here.

> +
> +    DBG("Got name %s", name);

and here.

> +	call->name_presentation =3D pres;
> +	strncpy(call->name, name, sizeof(call->name));
> +
> +	g_free(name);
> +}
> +
>  static void isi_call_mode_sb_proc(struct isi_voicecall *ivc,
>  					struct isi_call *call,
>  					GIsiSubBlockIter *sb)
> @@ -396,13 +422,19 @@ static struct ofono_call isi_call_as_ofono_call(con=
st struct isi_call *call)
>  	ocall.status =3D isi_call_status_to_clcc(call);
>  =

>  	memcpy(number->number, call->address, sizeof(number->number));
> +	memcpy(ocall.name, call->name, sizeof(ocall.name));
> +

Extra blank line here.

>  =

>  	number->type =3D 0x80 | call->addr_type;
>  	ocall.clip_validity =3D call->presentation & 3;
> +    ocall.cnap_validity =3D call->name_presentation & 3;

spaces here.

>  =

>  	if (ocall.clip_validity =3D=3D 0 && strlen(number->number) =3D=3D 0)
>  		ocall.clip_validity =3D 2;
>  =

> +	if (ocall.cnap_validity =3D=3D 0 && strlen(call->name) =3D=3D 0)
> +		ocall.cnap_validity =3D 2;
> +
>  	return ocall;
>  }
>  =

> @@ -513,11 +545,12 @@ static void isi_call_notify(struct ofono_voicecall =
*ovc, struct isi_call *call)
>  =

>  	ocall =3D isi_call_as_ofono_call(call);
>  =

> -	DBG("id=3D%u,%s,%u,\"%s\",%u,%u",
> +	DBG("id=3D%u,%s,%u,\"%s\",\"%s\",%u,%u",
>  		ocall.id,
>  		ocall.direction ? "terminated" : "originated",
>  		ocall.status,
>  		ocall.phone_number.number,
> +        ocall.name,

Spaces here.

>  		ocall.phone_number.type,
>  		ocall.clip_validity);
>  =

> @@ -622,6 +655,10 @@ static void isi_call_status_ind_cb(const GIsiMessage=
 *msg, void *data)
>  			isi_call_origin_address_sb_proc(ivc, call, &iter);
>  			break;
>  =

> +        case CALL_ORIGIN_INFO:

Extra spaces here.

> +			isi_call_origin_info_sb_proc(ivc, call, &iter);
> +			break;
> +
>  		case CALL_GSM_DETAILED_CAUSE:
>  		case CALL_DESTINATION_PRE_ADDRESS:
>  		case CALL_DESTINATION_POST_ADDRESS:
> diff --git a/src/voicecall.c b/src/voicecall.c
> index 4606668..b608394 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -1951,8 +1951,8 @@ void ofono_voicecall_notify(struct ofono_voicecall =
*vc,
>  	struct ofono_call *newcall;
>  =

>  	DBG("Got a voicecall event, status: %d, id: %u, number: %s"
> -			" called_number: %s", call->status, call->id,
> -			call->phone_number.number, call->called_number.number);
> +			" called_number: %s, name: %s", call->status, call->id,
> +			call->phone_number.number, call->called_number.number, call->name);

Code over 80 characters.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============0723164219727034620==--

