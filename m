Content-Type: multipart/mixed; boundary="===============6514233210291367545=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Tue, 12 Jan 2016 20:08:06 +0100
Message-ID: <87fuy2vco9.fsf@nemi.mork.no>
In-Reply-To: <CADnUhn2vxkMDZrBkTL98BryyOmzPUM=ivceK1ekcV+uLHgKZcQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6514233210291367545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

matti kaasinen <matti.kaasinen@gmail.com> writes:
> 2016-01-12 18:30 GMT+02:00 Denis Kenzior <denkenz@gmail.com>:
>
>> Please note, that there are two different versions of the Huawei cards
>> supported by oFono.  One uses the "gobi" driver (these are Qualcomm
>> chips).  While the more traditional one uses PPP & the "huawei" driver.
>
>
> I suppose I should edit setup_gobi() and vendor_list() as before in case
> it's "gobi"?

It's not "gobi".  At least not in the firmware cfg you are using.  The
255/2/22 class/subclass/protocol indicates an NCM function with an AT
command channel transported via SEND_ENCAPSULATED_COMMAND and
GET_ENCAPSULATED_RESPONSE.  The huawei_cdc_ncm driver will handle this,
exporting the AT command channel as a /dev/cdc-wdmX device.

The NCM network interface is managed via Huawei AT commands like e.g
AT^NDISDUP, either over the /dev/cdc-wdmX device or one of the serial
functions. Don't know if ofono supports that?  If not, then I guess PPP
is your option.


Bj=C3=B8rn

--===============6514233210291367545==--

