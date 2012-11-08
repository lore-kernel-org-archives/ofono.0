Content-Type: multipart/mixed; boundary="===============4004636307785552633=="
MIME-Version: 1.0
From: Jan Pohanka <xhpohanka@gmail.com>
Subject: Re: ofono and connecting to an APN
Date: Thu, 08 Nov 2012 13:00:28 +0100
Message-ID: <op.wngea2yoyxxkfz@pohanka-pc>
In-Reply-To: <509A7879.4000200@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4004636307785552633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

thank you for advices again.

>>> And yes, you can do voice calls, sms and internet at the same time
>>> with oFono. Assuming of course you have at least two ttys available or
>>> your modem supports multiplexing.
>>
>> Could you please give me some example how to connect a device to
>
> - test/enable-modem
> - test/online-modem
> - Wait for Attached Property on ConnectionManager interface to go to True
> - test/activate-context
> - test/process-context-settings

Just one additional question here

$ ./test/process-context-settings
Configuring /telit2_0/context1
     Interface is ppp0
     IP address is 10.9.8.171
     Gateway is 0.0.0.0
     Nameserver is 10.168.38.53
     Nameserver is 10.168.38.53
route: SIOCADDRT: File exists


Where these settings (addresses) come from (dhcp?), and why there is no  =

correct gateway? I'm also wondering if these commands are connecting  =

through GPRS or through 3G if I have 3G modem.

best regards
Jan

--===============4004636307785552633==--

