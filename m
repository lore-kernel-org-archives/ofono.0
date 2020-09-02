Content-Type: multipart/mixed; boundary="===============6896326969872125059=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: Unable to establish ppp connection with Huawei dongle
Date: Wed, 02 Sep 2020 13:00:55 +0200
Message-ID: <20200902110055.6yzsqncyjnxot5bv@lem-wkst-02.lemonage>
In-Reply-To: <20200902104627.2753.10666@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6896326969872125059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2020 at 10:46:27AM -0000, rakespani(a)gmail.com wrote:
> Hi Lars ,
> =

> I have updated ofono to 1.31 =

> =

> After that also same error message I am getting . I  captured pppdump for=
 this . I observe that I am not getting any response from the dongle. =


I think from the log you gave in your last mail that you are not
awaiting a response from the dongle but instead from your mobile
provider.

> So to verify if AT commands and APN settings are proper or not I followed=
 below steps using ofono & pppd .
> =

> 1. list-modems (ofono-testclient)
> 2. enable-modem (ofono-testclient)
> 3. create-internet-context airtelgprs.com(ofono-testclient)
> 4. online-modem (ofono-testclient)
> 5. echo -e -n 'AT+CGDCONT=3D1,"IP","airtelgprs.com"\r'  > /dev/ttyUSB0
> 6. echo -e -n 'AT+CGDATA=3D"PPP",1\r'  > /dev/ttyUSB0
> 7. /usr/sbin/pppd ttyUSB0 115200 usepeerdns nodetach crtscts noauth passi=
ve =

> =

> With this ppp interface is up . =


And now what exactly is the difference between the pppdump you captured
from ofono and the pppdump captured with pppd ?

Regards,
Lars
--===============6896326969872125059==--

