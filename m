Content-Type: multipart/mixed; boundary="===============8360205015897899211=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 3/5] udevng.c: tty assignment according OFONO_LABEL	should
 take precedence
Date: Mon, 19 Dec 2011 17:32:02 +0100
Message-ID: <4EEF6702.5090509@linux.intel.com>
In-Reply-To: <1324273728.1965.99.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8360205015897899211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 12/19/2011 06:48 AM, Marcel Holtmann wrote:
> Hi Philippe,
>
>>   plugins/udevng.c |   61 +++++++++++++++++++++++++++++++++-------------=
-------
>>   1 files changed, 38 insertions(+), 23 deletions(-)
>>
>> diff --git a/plugins/udevng.c b/plugins/udevng.c
>> index be87320..6a3c970 100644
>> --- a/plugins/udevng.c
>> +++ b/plugins/udevng.c
>> @@ -235,6 +235,7 @@ static gboolean setup_sierra(struct modem_info *mode=
m)
>>   static gboolean setup_huawei(struct modem_info *modem)
>>   {
>>   	const char *mdm =3D NULL, *pcui =3D NULL, *diag =3D NULL;
>> +	const char *default_pcui =3D NULL;
>>   	GSList *list;
>>
>>   	DBG("%s", modem->syspath);
>> @@ -264,19 +265,24 @@ static gboolean setup_huawei(struct modem_info *mo=
dem)
>>   			if (mdm !=3D NULL&&  pcui !=3D NULL)
>>   				break;
>>   		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
>> -			if (g_strcmp0(info->number, "00") =3D=3D 0)
>> +			if (mdm =3D=3D NULL&&  g_strcmp0(info->number, "00") =3D=3D 0)
>>   				mdm =3D info->devnode;
>> -			else if (g_strcmp0(info->number, "01") =3D=3D 0)
>> -				pcui =3D info->devnode;
>> -			else if (g_strcmp0(info->number, "02") =3D=3D 0)
>> -				pcui =3D info->devnode;
>> -			else if (g_strcmp0(info->number, "03") =3D=3D 0)
>> -				pcui =3D info->devnode;
>> -			else if (g_strcmp0(info->number, "04") =3D=3D 0)
>> -				pcui =3D info->devnode;
>> +			else if (pcui =3D=3D NULL) {
>> +				if (g_strcmp0(info->number, "01") =3D=3D 0)
>> +					default_pcui =3D info->devnode;
>> +				else if (g_strcmp0(info->number, "02") =3D=3D 0)
>> +					default_pcui =3D info->devnode;
>> +				else if (g_strcmp0(info->number, "03") =3D=3D 0)
>> +					default_pcui =3D info->devnode;
>> +				else if (g_strcmp0(info->number, "04") =3D=3D 0)
>> +					default_pcui =3D info->devnode;
>> +			}
>>   		}
>>   	}
>>
>> +	if (pcui =3D=3D NULL&&  default_pcui !=3D NULL)
>> +		pcui =3D default_pcui;
>> +
>
> what is this default_pcui doing here. I am failing to understand its
> usage.

We need to prevent the assignment done through the label, to be =

overridden by the 'default' assignment (the one done by the implicit rule).

That's why I introduced new conditions:

	if (mdm =3D=3D NULL && g_strcmp0(info->number, "00") =3D=3D 0)

	and

	else if (pcui =3D=3D NULL) {

In practice, if the pcui is already assigned through the label, the =

'default' assignment' algorithm is not considered.
On the contrary, the 'default' assignment is done using a dedicated =

variable 'default_pcui'.
If we were still using the variable 'pcui', we couldn't update anymore =

this variable through the 'default' assignment due to the new condition =

'if (pcui =3D=3D NULL)'.

>
>>   	if (mdm =3D=3D NULL || pcui =3D=3D NULL)
>>   		return FALSE;
>>
>> @@ -291,7 +297,7 @@ static gboolean setup_huawei(struct modem_info *mode=
m)
>>
>>   static gboolean setup_speedup(struct modem_info *modem)
>>   {
>> -	const char *aux =3D NULL, *mdm =3D NULL;
>> +	const char *aux =3D NULL, *mdm =3D NULL, *default_mdm =3D NULL;
>>   	GSList *list;
>>
>>   	DBG("%s", modem->syspath);
>> @@ -311,15 +317,20 @@ static gboolean setup_speedup(struct modem_info *m=
odem)
>>   			if (aux !=3D NULL)
>>   				break;
>>   		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
>> -			if (g_strcmp0(info->number, "01") =3D=3D 0)
>> +			if (aux =3D=3D NULL&&  g_strcmp0(info->number, "01") =3D=3D 0)
>>   				aux =3D info->devnode;
>> -			else if (g_strcmp0(info->number, "02") =3D=3D 0)
>> -				mdm =3D info->devnode;
>> -			else if (g_strcmp0(info->number, "03") =3D=3D 0)
>> -				mdm =3D info->devnode;
>> +			else if (mdm =3D=3D NULL) {
>> +				if (g_strcmp0(info->number, "02") =3D=3D 0)
>> +					default_mdm =3D info->devnode;
>> +				else if (g_strcmp0(info->number, "03") =3D=3D 0)
>> +					default_mdm =3D info->devnode;
>> +			}
>>   		}
>>   	}
>>
>> +	if (mdm =3D=3D NULL&&  default_mdm !=3D NULL)
>> +		mdm =3D default_mdm;
>> +
>
> Same here. This makes the code pretty much unreadable.

This logic becomes however necessary as I introduced dedicated rules for =

Speedup and Huawei based on the label.
Without this patch, the 'label' assignment doesn't work necessarily (in =

fact, it depends of the order of the interfaces).


>
>>   	if (aux =3D=3D NULL || mdm =3D=3D NULL)
>>   		return FALSE;
>>
>> @@ -385,9 +396,10 @@ static gboolean setup_alcatel(struct modem_info *mo=
dem)
>>   			if (aux !=3D NULL)
>>   				break;
>>   		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
>> -			if (g_strcmp0(info->number, "03") =3D=3D 0)
>> +			if (aux =3D=3D NULL&&  g_strcmp0(info->number, "03") =3D=3D 0)
>>   				aux =3D info->devnode;
>> -			else if (g_strcmp0(info->number, "05") =3D=3D 0)
>> +			else if (mdm =3D=3D NULL&&
>> +					g_strcmp0(info->number, "05") =3D=3D 0)
>>   				mdm =3D info->devnode;
>>   		}
>>   	}
>> @@ -425,9 +437,10 @@ static gboolean setup_novatel(struct modem_info *mo=
dem)
>>   			if (aux !=3D NULL)
>>   				break;
>>   		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
>> -			if (g_strcmp0(info->number, "00") =3D=3D 0)
>> +			if (aux =3D=3D NULL&&  g_strcmp0(info->number, "00") =3D=3D 0)
>>   				aux =3D info->devnode;
>> -			else if (g_strcmp0(info->number, "01") =3D=3D 0)
>> +			else if (mdm =3D=3D NULL&&
>> +					g_strcmp0(info->number, "01") =3D=3D 0)
>>   				mdm =3D info->devnode;
>>   		}
>>   	}
>> @@ -465,9 +478,10 @@ static gboolean setup_nokia(struct modem_info *mode=
m)
>>   			if (aux !=3D NULL)
>>   				break;
>>   		} else if (g_strcmp0(info->interface, "10/0/0") =3D=3D 0) {
>> -			if (g_strcmp0(info->number, "02") =3D=3D 0)
>> +			if (mdm =3D=3D NULL&&  g_strcmp0(info->number, "02") =3D=3D 0)
>>   				mdm =3D info->devnode;
>> -			else if (g_strcmp0(info->number, "04") =3D=3D 0)
>> +			else if (aux =3D=3D NULL&&
>> +					g_strcmp0(info->number, "04") =3D=3D 0)
>>   				aux =3D info->devnode;
>>   		}
>>   	}
>> @@ -505,13 +519,14 @@ static gboolean setup_telit(struct modem_info *mod=
em)
>>   			if (aux !=3D NULL)
>>   				break;
>>   		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
>> -			if (g_strcmp0(info->number, "00") =3D=3D 0)
>> +			if (mdm =3D=3D NULL&&  g_strcmp0(info->number, "00") =3D=3D 0)
>>   				mdm =3D info->devnode;
>>   			else if (g_strcmp0(info->number, "01") =3D=3D 0)
>>   				diag =3D info->devnode;
>>   			else if (g_strcmp0(info->number, "02") =3D=3D 0)
>>   				gps =3D info->devnode;
>> -			else if (g_strcmp0(info->number, "03") =3D=3D 0)
>> +			else if (aux =3D=3D NULL
>> +					&&  g_strcmp0(info->number, "03") =3D=3D 0)
>>   				aux =3D info->devnode;
>>   		}
>>   	}
>
> This becomes unreadable. What are we trying to achieve here.

For Alcatel, Novatel, Nokia, Telit, I don't have a bug stating that we =

could have an overriding issue.
I just propagated the logic explained above for more safety.

Regards,

Philippe.


>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


--===============8360205015897899211==--

