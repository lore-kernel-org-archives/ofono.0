Content-Type: multipart/mixed; boundary="===============6742868703820764022=="
MIME-Version: 1.0
From: sebastian.wans@physec.de
Subject: Re: Roaming SIM card does not get APN and internet connection
Date: Tue, 06 Jul 2021 07:15:01 +0000
Message-ID: <20210706071501.2743.29057@ml01.vlan13.01.org>
In-Reply-To: <cde4dc4b-cb0e-9d75-a40e-e7052d476f46@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6742868703820764022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks for the quick response. Yes that is correct. I'm using a Kerlink iSt=
ation. I have configured the provisioning file by adding the MCC/MNC and th=
e APN as shown below. This setup with adjusted parameters works for differe=
nt providers without any problem but I might have forgotten something here.=
 I also rebooting, reseting, removing the SIM-specific folders and so on to=
 make sure I used the latest file but it hasn't helped.

Best regards

[operator:262,03]
internet.AccessPointName=3Diotde.telefonica.com

# it's actually 05 and not 07 as mentioned in my first post
[operator:262,05]
internet.AccessPointName=3Diotde.telefonica.com

[operator:262,77]
internet.AccessPointName=3Diotde.telefonica.com
--===============6742868703820764022==--

