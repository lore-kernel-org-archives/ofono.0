Content-Type: multipart/mixed; boundary="===============3594676933873290988=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH qmi lte v4 5/6] qmi: add LTE atom driver
Date: Fri, 21 Apr 2017 06:05:01 +0200
Message-ID: <6a58efcc-341c-d441-dc22-83760913db2b@southpole.se>
In-Reply-To: <7e28374d-0e0f-76fc-5140-4f246fd837be@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3594676933873290988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 04/20/2017 07:03 PM, Denis Kenzior wrote:
> Hi Jonas,
>
> On 04/18/2017 02:50 AM, Jonas Bonn wrote:
>> +    if (strlen(info->apn) > 0)
>> +        ldd->apn =3D g_strdup(info->apn);
>> +    else
>> +        ldd->apn =3D NULL;
>> +
>
> Why do you want to store the APN inside the driver data?

Just to do _something_ with the APN until the FIXME below gets fixed.  =

There's no reason to store it in the long run.

>
>> +    /*
>> +     * FIXME: The above is not sufficient.  The APN needs to be set
>> +     * to the 'default' profile so that the modem uses it when
>> +     * connecting the default bearer.
>> +     */
>> +    ofono_warn("LTE APN needs to be written to default profile");


>> +
>> +    qmi_service_create(device, QMI_SERVICE_WDS,
>> +                    create_wds_cb, lte, NULL);
>> +
>
> So I talked to Marcel about this and it seems a QMI service cannot be =

> created multiple times for the same device.  So I think this should =

> fail and you should be using qmi_service_create_shared instead.

OK, thanks for noticing this.  I was, in fact, wondering about this, too.

The QMI changes that I have made in the last few weeks have created the =

same service in multiple atoms (gprs, network-registration, =

gprs-context).  That _does_ actually work on my EC21 which is a pretty =

new Qualcomm chip.  But if older chips have problems with this then I =

suppose this will need to be fixed in the other atoms, too.  I will do so.

/Jonas


--===============3594676933873290988==--

