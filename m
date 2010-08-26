Content-Type: multipart/mixed; boundary="===============3317631795330054142=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [sim-fdn PATCH 1/4] sim: add EnableFDN and DisableFDN methods
Date: Thu, 26 Aug 2010 10:59:46 -0500
Message-ID: <4C768F72.9090905@gmail.com>
In-Reply-To: <AANLkTinEf+aYvROkSJFEen9ameRZ0+MeLbRNfkdXyphC@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3317631795330054142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 08/26/2010 10:54 AM, Pekka Pessi wrote:
> 2010/8/26 Denis Kenzior <denkenz@gmail.com>:
>> Hi Pekka,
>>
>> On 08/26/2010 07:52 AM, Pekka.Pessi(a)nokia.com wrote:
>>> From: Pekka Pessi <Pekka.Pessi@nokia.com>
>>>
>>> Enable or disable Fixed Dialing Numbers feature on SIM card.
>>>
>>> If enabled, calls can be dialled or SMSs sent only to numbers listed on
>>> special FDN phonebook on the SIM card.
>>
>> FDN has serious implications for the rest of the system, particularly on
>> SMS atom and Sim Toolkit.  oFono will either have to support the entire
>> thing properly or use a 'limited' FDN mode (e.g. if FDN is enabled, we
>> only permit emergency calls.)
> =

>> We have really not made our mind what makes sense here yet.
> =

> I think most modems support FDN in the firmware. (Well, famous last
> words.) I don't think it makes any sense to support or "support" it in
> oFono.
> =


You're correct.  However, if FDN is enabled, carriers require that SMSes
to numbers not in FDN to be rejected.  It is quite unclear whether this
is done in the firmware or not.  If oFono has to handle it internally,
then we also require access to the FDN phonebook.

Sim Toolkit interactions require FDN to be explicitly ignored for Send
SMS, Setup Call.  If these are not handled in the firmware, then we
can't properly support FDN.

Regards,
-Denis

--===============3317631795330054142==--

