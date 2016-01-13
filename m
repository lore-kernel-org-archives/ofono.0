Content-Type: multipart/mixed; boundary="===============4923642497780697211=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Wed, 13 Jan 2016 10:08:13 -0600
Message-ID: <5696766D.9060307@gmail.com>
In-Reply-To: <87fuy2vco9.fsf@nemi.mork.no>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4923642497780697211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On 01/12/2016 01:08 PM, Bj=C3=B8rn Mork wrote:
> matti kaasinen <matti.kaasinen@gmail.com> writes:
>> 2016-01-12 18:30 GMT+02:00 Denis Kenzior <denkenz@gmail.com>:
>>
>>> Please note, that there are two different versions of the Huawei cards
>>> supported by oFono.  One uses the "gobi" driver (these are Qualcomm
>>> chips).  While the more traditional one uses PPP & the "huawei" driver.
>>
>>
>> I suppose I should edit setup_gobi() and vendor_list() as before in case
>> it's "gobi"?
>
> It's not "gobi".  At least not in the firmware cfg you are using.  The
> 255/2/22 class/subclass/protocol indicates an NCM function with an AT
> command channel transported via SEND_ENCAPSULATED_COMMAND and
> GET_ENCAPSULATED_RESPONSE.  The huawei_cdc_ncm driver will handle this,
> exporting the AT command channel as a /dev/cdc-wdmX device.

I suspected as much.  Thanks for confirming that.

>
> The NCM network interface is managed via Huawei AT commands like e.g
> AT^NDISDUP, either over the /dev/cdc-wdmX device or one of the serial
> functions. Don't know if ofono supports that?  If not, then I guess PPP
> is your option.

Looks like Marcel added support for this back in 2010: =

bfd2c768cd97e92347325363b92292cd6bb27e9f.  But it looks like the =

'huawei' driver was never updated to make use of it.

Regards,
-Denis

--===============4923642497780697211==--

