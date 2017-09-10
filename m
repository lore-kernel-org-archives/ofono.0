Content-Type: multipart/mixed; boundary="===============4912572834784919008=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmimodem: implement SIM write_file_linear
Date: Sun, 10 Sep 2017 13:12:27 -0500
Message-ID: <473f6daa-c2da-0389-24d6-f8c51407a591@gmail.com>
In-Reply-To: <20170910065410.966C9642AA@rivendell.scintill.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4912572834784919008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joey,

On 09/10/2017 12:48 AM, Joey Hewitt wrote:
> cyclic and transparent not enabled, because I haven't tested them.
> ---
> =

> I wonder what to do with sw1 and sw2. I've seen in the case of a read,
> that a file-not-found is converted into a QMI error in addition to the
> SW values being returned. I'm checking for QMI error before sw1/2. I
> don't know if all SIM errors are returned with QMI error. Should sw1/2
> error take precedence over a QMI error so that the callback can get those
> values?
> =

> The QMI read_generic_cb() isn't checking the SW values, although I
> believe they're available there as well. Thoughts on what's best?

The core will handle both cases.  Ideally I'd like the drivers to =

provide sw1 and sw2 if available, but this all depends on how QMI =

behaves.  If sw1/sw2 is always returned from QMI_UIM_WRITE_* requests, =

then just return those and don't bother checking the qmi_result_set_error.

In theory if card_result object isn't provided, then qmi_result_get will =

fail and we'll get the same generic failure callback anyway.

> =

>   drivers/qmimodem/sim.c | 117 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 117 insertions(+)
> =

> diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
> index 8d40028..ce2261a 100644
> --- a/drivers/qmimodem/sim.c
> +++ b/drivers/qmimodem/sim.c
> @@ -317,6 +317,121 @@ error:
>   	g_free(cbd);
>   }
>   =

> +static void write_generic_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_sim_write_cb_t cb =3D cbd->cb;
> +	const unsigned char *card_result;
> +	uint16_t len;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, NULL)) {
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	card_result =3D qmi_result_get(result, 0x10, &len);
> +	if (!card_result || len !=3D 2) {
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	const uint8_t sw1 =3D card_result[0], sw2 =3D card_result[1];
> +

Don't mix code & declarations.  We're not using C99

> +	if ((sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92 && sw1 !=3D 0x9f) =
||
> +			(sw1 =3D=3D 0x90 && sw2 !=3D 0x00)) {
> +		struct ofono_error error;
> +
> +		ofono_error("%s: error sw1 %02x sw2 %02x", __func__, sw1, sw2);
> +
> +		error.type =3D OFONO_ERROR_TYPE_SIM;
> +		error.error =3D (sw1 << 8) | sw2;
> +
> +		cb(&error, cbd->data);
> +		return;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +}
> +
> +void write_generic(struct ofono_sim *sim,
> +			uint16_t qmi_message, int fileid, int start_or_recordnum, int length,
> +			const unsigned char *value, const unsigned char *path, unsigned int p=
ath_len,
> +			ofono_sim_write_cb_t cb, void *user_data)

Lines should not be > 80 characters.  If in doubt, run checkpatch.pl =

from the Linux kernel and it should point out the most obvious mistakes. =

  Our coding style is the same with some house additions outlined in =

doc/coding-style.txt

> +{
> +	struct sim_data *data =3D ofono_sim_get_data(sim);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	unsigned char aid_data[2] =3D { 0x00, 0x00 };
> +	unsigned char *write_data;
> +	unsigned char fileid_data[9];
> +	int fileid_len;
> +	struct qmi_param *param;
> +
> +	DBG("file id 0x%04x path len %d", fileid, path_len);
> +
> +	fileid_len =3D create_fileid_data(data->app_type, fileid, path, path_le=
n, fileid_data);
> +	if (fileid_len < 0)
> +		goto error;
> +
> +	write_data =3D alloca(4 + length);

or simply declare write_data above as:

unsigned char write_data[4 + length].  gcc lets you do that

> +	write_data[0] =3D start_or_recordnum & 0xff;
> +	write_data[1] =3D (start_or_recordnum & 0xff00) >> 8;
> +	write_data[2] =3D length & 0xff;
> +	write_data[3] =3D (length & 0xff00) >> 8;
> +	memcpy(&write_data[4], value, length);
> +
> +	param =3D qmi_param_new();
> +	if (!param)
> +		goto error;
> +
> +	qmi_param_append(param, 0x01, sizeof(aid_data), aid_data);
> +	qmi_param_append(param, 0x02, fileid_len, fileid_data);
> +	qmi_param_append(param, 0x03, 4 + length, write_data);
> +
> +	if (qmi_service_send(data->uim, qmi_message, param,
> +						write_generic_cb, cbd, g_free) > 0)
> +		return;
> +
> +	qmi_param_free(param);
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, user_data);
> +
> +	g_free(cbd);
> +}
> +
> +

Avoid double empty lines please

> +static void qmi_write_transparent(struct ofono_sim *sim,
> +				int fileid, int start, int length,
> +				const unsigned char *value,
> +				const unsigned char *path,
> +				unsigned int path_len,
> +				ofono_sim_write_cb_t cb, void *user_data)
> +{
> +	write_generic(sim, QMI_UIM_WRITE_TRANSPARENT, fileid, start, length, va=
lue, path, path_len, cb, user_data);

 > 80 chars

> +}
> +
> +static void qmi_write_linear(struct ofono_sim *sim,
> +				int fileid, int record, int length,
> +				const unsigned char *value,
> +				const unsigned char *path,
> +				unsigned int path_len,
> +				ofono_sim_write_cb_t cb, void *user_data)
> +{
> +	write_generic(sim, QMI_UIM_WRITE_RECORD, fileid, record, length, value,=
 path, path_len, cb, user_data);

 > 80 chars

> +}
> +
> +static void qmi_write_cyclic(struct ofono_sim *sim,
> +				int fileid, int length,
> +				const unsigned char *value,
> +				const unsigned char *path,
> +				unsigned int path_len,
> +				ofono_sim_write_cb_t cb, void *user_data)
> +{
> +	write_generic(sim, QMI_UIM_WRITE_RECORD, fileid, 0, length, value, path=
, path_len, cb, user_data);
> +}
> +
>   static void get_imsi_cb(struct qmi_result *result, void *user_data)
>   {
>   	struct cb_data *cbd =3D user_data;
> @@ -777,6 +892,8 @@ static struct ofono_sim_driver driver =3D {
>   	.read_file_transparent	=3D qmi_read_transparent,
>   	.read_file_linear	=3D qmi_read_record,
>   	.read_file_cyclic	=3D qmi_read_record,
> +	.write_file_linear	=3D qmi_write_linear,
> +	// transparent and cyclic not exposed, because they haven't been tested

I can't apply this as is as the compiler will generate unused function =

warnings for qmi_write_transparent and qmi_write_cyclic.  Our warnings =

are treated as errors.

I think its safe to simply enable .write_file_transparent and =

.write_file_cyclic here.  If things fail, we can fix them later.

>   	.read_imsi		=3D qmi_read_imsi,
>   	.query_passwd_state	=3D qmi_query_passwd_state,
>   	.query_pin_retries	=3D qmi_query_pin_retries,
> =


Regards,
-Denis

--===============4912572834784919008==--

