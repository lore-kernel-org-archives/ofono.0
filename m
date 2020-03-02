Content-Type: multipart/mixed; boundary="===============5470253708261877277=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Re: Expose MBPI api over d-bus
Date: Mon, 02 Mar 2020 14:38:08 +0000
Message-ID: <CABPh3UPXY5G2BxqG-AUx15issHvtj=uZFo4Lu9-hyPnRYL=uXA@mail.gmail.com>
In-Reply-To: <bfbeb7a8-3b94-edd7-7f1f-a33f9f4b3679@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5470253708261877277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,
Yes because the current behaviour in my opinion doesn't make any sense :-)

Currently ofono creates an invalid empty internet context with no apn at all

[ /telit_0 ]
    [ /telit_0/context1 ]
        Name =3D Internet
        Active =3D 0
        Type =3D internet
        Protocol =3D ip
        AccessPointName =3D
        Username =3D
        Password =3D
        AuthenticationMethod =3D chap
        Settings =3D { }
        IPv6.Settings =3D { }

[ /stktest ]

instead of

nlunghiadm(a)nick-bbestie:~/tmp/modem/ofono$ test/list-contexts
[ /telit_0 ]
    [ /telit_0/context1 ]
        Name =3D Internet
        Active =3D 0
        Type =3D internet
        Protocol =3D ip
        AccessPointName =3D hs.vodafone.ie
        Username =3D vodafone
        Password =3D vodafone
        AuthenticationMethod =3D chap
        Settings =3D { }
        IPv6.Settings =3D { }

    [ /telit_0/context2 ]
        Name =3D Old
        Active =3D 0
        Type =3D internet
        Protocol =3D ip
        AccessPointName =3D isp.vodafone.ie
        Username =3D vodafone
        Password =3D vodafone
        AuthenticationMethod =3D chap
        Settings =3D { }
        IPv6.Settings =3D { }

    [ /telit_0/context3 ]
        Name =3D Prepaid
        Active =3D 0
        Type =3D internet
        Protocol =3D ip
        AccessPointName =3D live.vodafone.com
        Username =3D vodafone
        Password =3D vodafone
        AuthenticationMethod =3D chap
        Settings =3D { }
        IPv6.Settings =3D { }
[ /stktest ]

I'll test if connman handles this and then I will resubmit your patch

the alternative could be to provide a DBus Interface to query the apn
from mbpi and then set it via DBus would be better??

Cheers
Nicola Lunghi

On Mon, 2 Mar 2020 at 13:56, Martin Hundeb=C3=B8ll <martin@geanix.com> wr=
ote:
>
> Hi,
>
> On 02/03/2020 14.49, nick83ola wrote:
> > Hi all,
> > In regarding to this I found the provision plugin and at line 53 it
> > uses the mbpi lookup to provision for the default apns but at line 53
> > it does
> >
> > apns =3D mbpi_lookup_apn(mcc, mnc, FALSE, &error);
> >
> > that gives an error in case of multiple providers. -> but if I change
> > it to gboolean allow_duplicates=3DTRUE
> > It works and it creates multiple contexts
> >
> > ap_count =3D g_slist_length(apns);
> > .....
> > for (l =3D apns, i =3D 0; l; l =3D l->next, i++) {
> > struct ofono_gprs_provision_data *ap =3D l->data;
> >
> > memcpy(*settings + i, ap,
> > sizeof(struct ofono_gprs_provision_data));
> >
> > g_free(ap);
> > }
> >
> > What's the issue in setting mbpi_lookup_apn(mcc, mnc, TRUE, &error); ??=
???
>
> You're not the first:
> https://lists.ofono.org/hyperkitty/list/ofono(a)ofono.org/thread/2SC46PH5=
CWT3A3HTHGUKUUVI3QDYIL73/#7B6CPARJQMZUBQUPXBJMAOXZY4RW2L3D
>
> :)
>
> // Martin
--===============5470253708261877277==--

