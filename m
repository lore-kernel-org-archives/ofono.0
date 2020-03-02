Content-Type: multipart/mixed; boundary="===============3879493145653560084=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Re: Expose MBPI api over d-bus
Date: Mon, 02 Mar 2020 15:01:42 +0000
Message-ID: <CABPh3UPa+fgaNp95LK07y9Gk60uZF9wxRvpdZQTOZ_QhjpXpsA@mail.gmail.com>
In-Reply-To: <CABPh3UPXY5G2BxqG-AUx15issHvtj=uZFo4Lu9-hyPnRYL=uXA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3879493145653560084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ok I just tested the patch with ofono/connman

connman correctly displays the 3 context as 3 separate services

    vodafone IE          cellular_272018013806642_context3
    vodafone IE          cellular_272018013806642_context2
    vodafone IE          cellular_272018013806642_context1

and permit to connect to one of thos

connmanctl connect cellular_272018013806642_context3

it also remember the profile where it was connected before and
reconnect to it if the modem is plugged in again

So I think the patch is valid.

Probably I need to submit a patch to connman to manipulate the context
from connman

I'll have a look at it later

Cheers
Nicola Lunghi

onnmanctl services
*AO vodafone IE          cellular_272018013806642_context3
*AR Wired                ethernet_0001c021c28c_cable
    vodafone IE          cellular_272018013806642_context1
    vodafone IE          cellular_272018013806642_context2
    wifi-aaa21c26a
wifi_c8df844b53ae_62756d626c656265652d323163323661_managed_psk
   ....

connmanctl services cellular_272018013806642_context3
/net/connman/service/cellular_272018013806642_context3
  Type =3D cellular
  Security =3D [  ]
  State =3D online
  Strength =3D 40
  Favorite =3D True
  Immutable =3D False
  AutoConnect =3D True
  Name =3D vodafone IE
  Roaming =3D False
  Ethernet =3D [ Method=3Dauto, Interface=3Dppp0, Address=3D00:00:00:00:00:=
00,
MTU=3D1500 ]
  IPv4 =3D [ Method=3Dfixed, Address=3D10.119.15.154, Netmask=3D255.255.255=
.255 ]
  IPv4.Configuration =3D [ Method=3Dfixed, Address=3D10.119.15.154,
Netmask=3D255.255.255.255 ]
  IPv6 =3D [  ]
  IPv6.Configuration =3D [ Method=3Doff ]
  Nameservers =3D [ 89.19.64.44, 89.19.64.172 ]
  Nameservers.Configuration =3D [  ]
  Timeservers =3D [  ]
  Timeservers.Configuration =3D [  ]
  Domains =3D [  ]
  Domains.Configuration =3D [  ]
  Proxy =3D [ Method=3Ddirect ]
  Proxy.Configuration =3D [  ]
  mDNS =3D False
  mDNS.Configuration =3D False
  Provider =3D [  ]

./list-context
[ /telit_2 ]
    [ /telit_2/context1 ]
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

    [ /telit_2/context2 ]
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

    [ /telit_2/context3 ]
        Name =3D Prepaid
        Active =3D 1
        Type =3D internet
        Protocol =3D ip
        AccessPointName =3D live.vodafone.com
        Username =3D vodafone
        Password =3D vodafone
        AuthenticationMethod =3D chap
        Settings =3D { Interface=3Dppp0 Method=3Dstatic
Address=3D10.119.15.154 Netmask=3D255.255.255.255
DomainNameServers=3D89.19.64.44,89.19.64.172, }
        IPv6.Settings =3D { }








diff --git a/plugins/provision.c b/plugins/provision.c
index 99c299eb..aa0b05e4 100644
--- a/plugins/provision.c
+++ b/plugins/provision.c
@@ -50,7 +50,7 @@ static int provision_get_settings(const char *mcc,
const char *mnc,

        DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);

-       apns =3D mbpi_lookup_apn(mcc, mnc, FALSE, &error);
+       apns =3D mbpi_lookup_apn(mcc, mnc, TRUE, &error);
        if (apns =3D=3D NULL) {
                if (error !=3D NULL) {
                        ofono_error("%s", error->message);

On Mon, 2 Mar 2020 at 14:38, nick83ola <nick83ola@gmail.com> wrote:
>
> Hi Martin,
> Yes because the current behaviour in my opinion doesn't make any sense :-)
>
> Currently ofono creates an invalid empty internet context with no apn at =
all
>
> [ /telit_0 ]
>     [ /telit_0/context1 ]
>         Name =3D Internet
>         Active =3D 0
>         Type =3D internet
>         Protocol =3D ip
>         AccessPointName =3D
>         Username =3D
>         Password =3D
>         AuthenticationMethod =3D chap
>         Settings =3D { }
>         IPv6.Settings =3D { }
>
> [ /stktest ]
>
> instead of
>
> nlunghiadm(a)nick-bbestie:~/tmp/modem/ofono$ test/list-contexts
> [ /telit_0 ]
>     [ /telit_0/context1 ]
>         Name =3D Internet
>         Active =3D 0
>         Type =3D internet
>         Protocol =3D ip
>         AccessPointName =3D hs.vodafone.ie
>         Username =3D vodafone
>         Password =3D vodafone
>         AuthenticationMethod =3D chap
>         Settings =3D { }
>         IPv6.Settings =3D { }
>
>     [ /telit_0/context2 ]
>         Name =3D Old
>         Active =3D 0
>         Type =3D internet
>         Protocol =3D ip
>         AccessPointName =3D isp.vodafone.ie
>         Username =3D vodafone
>         Password =3D vodafone
>         AuthenticationMethod =3D chap
>         Settings =3D { }
>         IPv6.Settings =3D { }
>
>     [ /telit_0/context3 ]
>         Name =3D Prepaid
>         Active =3D 0
>         Type =3D internet
>         Protocol =3D ip
>         AccessPointName =3D live.vodafone.com
>         Username =3D vodafone
>         Password =3D vodafone
>         AuthenticationMethod =3D chap
>         Settings =3D { }
>         IPv6.Settings =3D { }
> [ /stktest ]
>
> I'll test if connman handles this and then I will resubmit your patch
>
> the alternative could be to provide a DBus Interface to query the apn
> from mbpi and then set it via DBus would be better??
>
> Cheers
> Nicola Lunghi
>
> On Mon, 2 Mar 2020 at 13:56, Martin Hundeb=C3=B8ll <martin@geanix.com> =
wrote:
> >
> > Hi,
> >
> > On 02/03/2020 14.49, nick83ola wrote:
> > > Hi all,
> > > In regarding to this I found the provision plugin and at line 53 it
> > > uses the mbpi lookup to provision for the default apns but at line 53
> > > it does
> > >
> > > apns =3D mbpi_lookup_apn(mcc, mnc, FALSE, &error);
> > >
> > > that gives an error in case of multiple providers. -> but if I change
> > > it to gboolean allow_duplicates=3DTRUE
> > > It works and it creates multiple contexts
> > >
> > > ap_count =3D g_slist_length(apns);
> > > .....
> > > for (l =3D apns, i =3D 0; l; l =3D l->next, i++) {
> > > struct ofono_gprs_provision_data *ap =3D l->data;
> > >
> > > memcpy(*settings + i, ap,
> > > sizeof(struct ofono_gprs_provision_data));
> > >
> > > g_free(ap);
> > > }
> > >
> > > What's the issue in setting mbpi_lookup_apn(mcc, mnc, TRUE, &error); =
?????
> >
> > You're not the first:
> > https://lists.ofono.org/hyperkitty/list/ofono(a)ofono.org/thread/2SC46P=
H5CWT3A3HTHGUKUUVI3QDYIL73/#7B6CPARJQMZUBQUPXBJMAOXZY4RW2L3D
> >
> > :)
> >
> > // Martin
--===============3879493145653560084==--

