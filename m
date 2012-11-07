Content-Type: multipart/mixed; boundary="===============6249911430653606653=="
MIME-Version: 1.0
From: Jan Pohanka <xhpohanka@gmail.com>
Subject: Re: ofono and connecting to an APN
Date: Wed, 07 Nov 2012 07:42:17 +0100
Message-ID: <op.wnd4wrs4yxxkfz@pohanka-pc>
In-Reply-To: <50992742.7080109@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6249911430653606653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

thank you for the answer.

>
> oFono is the one establishing the GPRS context.  Some other daemon makes  =

> the control decisions on what context should be established and when.  =

> e.g. connman makes this decision in the case of Type=3Dinternet contexts  =

> and something like mmsd makes this decision for Type=3Dmms contexts.

I will check mmsd thank you for the info. Do you know if it is a mature  =

project? I mean if it can be used for basic mms sending?

>> task for another daemon like connman or something similar? If yes how
>> these daemons communicate with ofono when they are grabbing the
>> interface for making ppp conection?
>>
>
> I'm not quite sure I understand the question?  The context establishment  =

> is achieved using org.ofono.ConnectionContext interface, e.g. by setting  =

> the 'Active' property.  The PPP connection is done by oFono itself.

I'd like to use ofono to be able to do voice calls and sms messaging.
Without ofono, I'm able to connect to internet over PPP using pppd daemon  =

with proper script using one of the modem interfaces (ttyUSBx/ttyACMx).  =

Such connection can be done directly using ofono (without pppd)?

best regards
Jan

--===============6249911430653606653==--

