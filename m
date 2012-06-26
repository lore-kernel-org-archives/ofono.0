Content-Type: multipart/mixed; boundary="===============4276856463633363360=="
MIME-Version: 1.0
From: Audric Schiltknecht <audric.schiltknecht@toulouse.viveris.com>
Subject: Re: Unable to decode PDU for SMS-STATUS-REPORT
Date: Tue, 26 Jun 2012 09:18:00 +0200
Message-ID: <c0891f374d865e94c4fad5ffa5c3da07@toulouse.viveris.com>
In-Reply-To: <4FE42CC7.5050209@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4276856463633363360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On Fri, 22 Jun 2012 03:28:55 -0500, Denis Kenzior wrote:
> Hi Audric,
>
> On 06/25/2012 11:10 AM, Audric Schiltknecht wrote:
>> Hi guys.
>>
>> I'm having troubles with delivery reports.
>>
>> When I send a message with the property "UseDeliveryReports" set to =

>> "true",
>> I can get the delivery report from the GSM modem, but ofono is =

>> unable to
>> decode it:
>>
>> ofonod[677]: SMS: < \r\n+CDS:
>> =

>> 32\r\n07913386094000F006DB0A810011223344216052714081802160527140228000\r=
\n
>> ofonod[677]: drivers/atmodem/sms.c:at_cds_notify() Got new =

>> Status-Report
>> PDU via CDS:
>> 07913386094000F006DB0A810011223344216052714081802160527140228000, 32
>> ofonod[677]: src/sms.c:ofono_sms_status_notify() len 32 tpdu len 32
>> ofonod[677]: Unable to decode PDU
>>
>> The PDU is valid, since I can decode it using some online tool.
>>
>> It seems that sms_decode does not correctly handle the SMSCC part
>> (913386094000F0),
>> and tries to decode it as the sender address, which obviously fails.
>>
>
> Likely it is because your modem is being stupid.  3GPP 27.005 states:
>
> <length> integer type value indicating in the text mode (+CMGF=3D1) the
> length of the message body <data> > (or <cdata>) in characters; or in
> PDU mode (+CMGF=3D0), the length of the actual TP data unit in octets
> (i.e. the RP layer SMSC address octets are not counted in the length)
>
> So in the case above it should be reporting the length of the
> payload, not the length of the entire hex string.

Oh, I see. I must have missed this part in the specs.

>
> See if the PDU is decoded successfully by setting tpdu_len to the
> appropriate value.

You are quite right on this, the modem is to blame...
I should have guessed it ;-)

Thank you again for your help.

Regards,
Audric

--===============4276856463633363360==--

