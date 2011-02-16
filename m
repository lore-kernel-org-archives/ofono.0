Content-Type: multipart/mixed; boundary="===============0262674592687287031=="
MIME-Version: 1.0
From: Andreas WESTIN <andreas.westin@stericsson.com>
Subject: Re: [PATCH 05/18] plugins: add plugin for u8500
Date: Wed, 16 Feb 2011 16:27:41 +0100
Message-ID: <4D5BECED.6020705@stericsson.com>
In-Reply-To: <AANLkTi=pZCFHhe37OeydXf-XSa_AhES7Q2YfE6gT04sh@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0262674592687287031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 2011-02-16 15:26, Aki Niemi wrote:
> Hi,
>
> 2011/2/15 Andreas Westin<andreas.westin@stericsson.com>:
>> +static int u8500_probe(struct ofono_modem *modem)
>> +{
>> +       const char *ifname =3D ofono_modem_get_string(modem, "Interface"=
);
>> +       unsigned address =3D ofono_modem_get_integer(modem, "Address");
>> +       GIsiModem *isimodem;
>> +       GIsiClient *client =3D NULL;
>> +       GIsiPhonetNetlink *link =3D NULL;
>> +       struct isi_data *isi =3D NULL;
>> +
>> +       if (ifname =3D=3D NULL)
>> +               return -EINVAL;
>> +
>> +       DBG("(%p) with %s", modem, ifname);
>> +
>> +       isimodem =3D g_isi_modem_create_by_name(ifname);
>> +       if (isimodem =3D=3D NULL) {
>> +               DBG("Interface=3D%s: %s", ifname, strerror(errno));
>> +               return -errno;
>> +       }
>> +
>> +       if (!g_isi_modem_set_version(isimodem, modemversion))
>> +               return -EINVAL;
>
> I'm not going to add this API in GIsiModem. If we went this route, and
> used vendor quirks inside the isimodem driver, then it would make a
> whole lot more sense to do it in the driver create(), not here.
>
> But we're not going that route. Each driver detects the version of the
> ISI service it is talking to when it is probed.
>

Yes this should not be there, but maybe I misunderstood you regarding =

the version handling. I was under the impression that we checked the =

version we get from doing PN_MTC or PN_MODEM_MCE ?

Cheers
Andreas

--===============0262674592687287031==--

