Content-Type: multipart/mixed; boundary="===============2888381169041875476=="
MIME-Version: 1.0
From: Marius Gripsgard <marius@ubports.com>
Subject: Re: [PATCH] [qmimodem] Implement data capability bearer notify
Date: Wed, 10 Jun 2020 15:46:20 +0200
Message-ID: <801d764e-d121-a5d5-115b-dbedb3c59d12@ubports.com>
In-Reply-To: <e0aea3ce-53f1-498b-9eea-e52d7b0b60b1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2888381169041875476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

v2 patch sent with fixes :)

On 10.06.2020 05:11, Denis Kenzior wrote:
> Hi Marius,
>
> On 6/9/20 3:21 PM, Marius Gripsgard wrote:
>> This implements data capability bearer notify to qmi modem.
>> Since this is included in the serving system response this
>> just adds a new data extraction for dc.
>> ---
>> =C2=A0 drivers/qmimodem/gprs.c | 29 +++++++++++++++++++++++++++++
>> =C2=A0 drivers/qmimodem/nas.c=C2=A0 | 36 +++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 drivers/qmimodem/nas.h=C2=A0 | 23 +++++++++++++++++++++++
>> =C2=A0 3 files changed, 88 insertions(+)
>>
>
> Looks good, just couple of nitpicks:
>
>> diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
>> index 07adbe9a..0ba24da7 100644
>> --- a/drivers/qmimodem/gprs.c
>> +++ b/drivers/qmimodem/gprs.c
>> @@ -68,6 +68,29 @@ static bool extract_ss_info(struct qmi_result
>> *result, int *status, int *tech)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> =C2=A0 }
>> =C2=A0 +static bool extract_dc_info(struct qmi_result *result, int
>> *bearer_tech)
>> +{
>> +=C2=A0=C2=A0=C2=A0 const struct qmi_nas_data_capability *dc;
>> +=C2=A0=C2=A0=C2=A0 uint16_t len;
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("");
>> +
>> +=C2=A0=C2=A0=C2=A0 dc =3D qmi_result_get(result,
>> QMI_NAS_RESULT_DATA_CAPABILIT_STATUS, &len);
>
> Should this be CAPABILITY?
Yes :)
>
>> +=C2=A0=C2=A0=C2=A0 if (!dc)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> +
>> +=C2=A0=C2=A0=C2=A0 *bearer_tech =3D -1;
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < dc->cap_count; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG("radio tech in use %d", =
dc->cap[i]);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *bearer_tech =3D qmi_nas_cap=
_to_bearer_tech(dc->cap[i]);
>
> I'm fine with this, but out of curiosity: can there be multiple of
> these?=C2=A0 Are they sorted somehow? =


There can be more then one sim, but qmimodem currently does not handle
it. This is not the most pretty way of handling it, but i wanted to at
least print all of them but use the last one (as that should be the last
one in use). I also wanted to follow the same style as used above.

We could do dc->cap[cap_count-1], but would be nice to have both
extractions similar.

>
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return true;
>> +}
>> +
>> +
>
> No double empty lines please
Wops, didn't see those
>
>> =C2=A0 static void get_lte_attach_param_cb(struct qmi_result *result, vo=
id
>> *user_data)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ofono_gprs *gprs =3D user_data;
>> @@ -188,6 +211,7 @@ static int handle_ss_info(struct qmi_result
>> *result, struct ofono_gprs *gprs)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gprs_data *data =3D ofono_gprs_get=
_data(gprs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int status;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int tech;
>> +=C2=A0=C2=A0=C2=A0 int bearer_tech;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG("");
>> =C2=A0 @@ -209,6 +233,11 @@ static int handle_ss_info(struct qmi_result
>> *result, struct ofono_gprs *gprs)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->last_auto_c=
ontext_id =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (!extract_dc_info(result, &bearer_tech))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>
> So bearer_tech is pretty much optional, are you sure you want to
> return an error here if the extraction fails?=C2=A0 Maybe something like:
>
> if (extract_dc_info(result, &bearer_tech)
> =C2=A0=C2=A0=C2=A0=C2=A0ofono_grps_bearer_notify(gprs, bearer_tech);
>
> would be a bit more conservative.
Yes i agree, we should still return ss return value even if bearer is
not available.
>
>> +
>> +=C2=A0=C2=A0=C2=A0 ofono_gprs_bearer_notify(gprs, bearer_tech);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return status;
>> =C2=A0 }
>> =C2=A0 =

>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org

--===============2888381169041875476==--

