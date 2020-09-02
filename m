Content-Type: multipart/mixed; boundary="===============0180538771520264914=="
MIME-Version: 1.0
From: rakespani@gmail.com
Subject: Re: Unable to establish ppp connection with Huawei dongle
Date: Wed, 02 Sep 2020 10:46:27 +0000
Message-ID: <20200902104627.2753.10666@ml01.vlan13.01.org>
In-Reply-To: <20200831141410.pxslwzm5nyiw7yq5@lem-wkst-02.lemonage>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0180538771520264914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars ,

I have updated ofono to 1.31 =


After that also same error message I am getting . I  captured pppdump for t=
his . I observe that I am not getting any response from the dongle. =


So to verify if AT commands and APN settings are proper or not I followed b=
elow steps using ofono & pppd .

1. list-modems (ofono-testclient)
2. enable-modem (ofono-testclient)
3. create-internet-context airtelgprs.com(ofono-testclient)
4. online-modem (ofono-testclient)
5. echo -e -n 'AT+CGDCONT=3D1,"IP","airtelgprs.com"\r'  > /dev/ttyUSB0
6. echo -e -n 'AT+CGDATA=3D"PPP",1\r'  > /dev/ttyUSB0
7. /usr/sbin/pppd ttyUSB0 115200 usepeerdns nodetach crtscts noauth passive =


With this ppp interface is up . =


I am using Huawei E392 Modem.

Regards,
Rakes
--===============0180538771520264914==--

