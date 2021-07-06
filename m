Content-Type: multipart/mixed; boundary="===============8871504901995554711=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: Roaming SIM card does not get APN and internet connection
Date: Tue, 06 Jul 2021 09:51:47 +0200
Message-ID: <96ff99a2-c1b5-2538-4e6e-8e360d8ed598@kerlink.fr>
In-Reply-To: <20210706071501.2743.29057@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8871504901995554711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

In provisioning file, you should use SIM card MCC/MNC and not MCC/MNC of
network operator.

Your SIM card MCC/MNC is 214,07. In provisionning file, you need:

[operator:214,07]
internet.AccessPointName=3Diotde.telefonica.com

As you already did, after modifying provisioning file, do
/etc/init.d/ofono reset to remove SIM-specific folders.

Best Regards,
Christophe

On 7/6/21 9:15 AM, sebastian.wans(a)physec.de wrote:
> Thanks for the quick response. Yes that is correct. I'm using a Kerlink i=
Station. I have configured the provisioning file by adding the MCC/MNC and =
the APN as shown below. This setup with adjusted parameters works for diffe=
rent providers without any problem but I might have forgotten something her=
e. I also rebooting, reseting, removing the SIM-specific folders and so on =
to make sure I used the latest file but it hasn't helped.
>
> Best regards
>
> [operator:262,03]
> internet.AccessPointName=3Diotde.telefonica.com
>
> # it's actually 05 and not 07 as mentioned in my first post
> [operator:262,05]
> internet.AccessPointName=3Diotde.telefonica.com
>
> [operator:262,77]
> internet.AccessPointName=3Diotde.telefonica.com
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
--===============8871504901995554711==--

