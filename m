Content-Type: multipart/mixed; boundary="===============2218124713504976059=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: Re: Testing the iPhone 5
Date: Fri, 10 May 2013 12:14:47 +0200
Message-ID: <CANT-zCVoxX1=p_ogY73Y1iEqBebEJHf=mhBW0SasqtOKdAUVgA@mail.gmail.com>
In-Reply-To: <518A8077.2030005@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2218124713504976059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, May 8, 2013 at 6:42 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Mikel,
>
>
> On 05/08/2013 08:59 AM, Mikel Astiz wrote:
>>
>> Hi,
>>
>> I promised Denis I'd send some traces after testing the iPhone 5 and
>> observing some strange states such as two active calls (test 1) or
>> active+dialing state (test 2).
>>
>> I currently don't have a phone to test with but let me reuse some
>> previous logs. In the second log, the AT commands are not visible so
>> I'm hoping to repeat the experiment fairly soon.
>>
>> The first test is probably a bug in oFono while the second one might
>> be the phone's behavior, to be confirmed.
>>
>> Cheers,
>> Mikel
>>
>> TEST 1:
>>
>> Steps: Two numbers dialer from the phone while 3-way calling not
>> available in network
>> Result: Two active calls in oFono (but phone shows only the first one)
>>
>> ofonod[14366]: < \r\n+CIEV: 3,2\r\n
>> ofonod[14366]: > AT+CLCC\r
>> ofonod[14366]: < \r\n+CLCC: 1,0,2,0,0,"<phone-number-1>",145\r\n
>> ofonod[14366]: < \r\nOK\r\n
>> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
>> voicecall event, status: 2, id: 1, number: <phone-number-1>
>> called_number: , called_name
>> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Did not find a
>> call with id: 1
>> ofonod[14366]: < \r\n+CIEV: 3,3\r\n
>> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
>> voicecall event, status: 3, id: 1, number: <phone-number-1>
>> called_number: , called_name
>> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Found call with
>> id: 1
>> ofonod[14366]: < \r\n+CIEV: 5,5\r\n
>> ofonod[14366]: src/network.c:ofono_netreg_strength_notify() strength 100
>> ofonod[14366]: < \r\n+CIEV: 2,1\r\n
>> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
>> voicecall event, status: 0, id: 1, number: <phone-number-1>
>> called_number: , called_name
>> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Found call with
>> id: 1
>> ofonod[14366]: < \r\n+CIEV: 3,0\r\n
>>
>> (At this point, a second call is dialed from the phone)
>>
>> ofonod[14366]: < \r\n+CIEV: 3,2\r\n
>> ofonod[14366]: > AT+CLCC\r
>> ofonod[14366]: < \r\n+CLCC: 1,0,0,0,0,"<phone-number-1>",145\r\n
>> ofonod[14366]: < \r\n+CLCC: 2,0,2,0,0,"<phone-number-2>",129\r\n
>
>
> So here we have call with index 1 in state 'Active' and call with index 2=
 in
> state 'Dialing'.  Obviously a bug with the iPhone.

Is this the kind of bug oFono is interested in fixing as IOP issue? Or
is it something acceptable in oFono's API?

Cheers,
Mikel

>
>
>> ofonod[14366]: < \r\nOK\r\n
>> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
>> voicecall event, status: 2, id: 2, number: <phone-number-2>
>> called_number: , called_name
>> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Did not find a
>> call with id: 2
>> ofonod[14366]: < \r\n+CIEV: 3,0\r\n
>> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Got a
>> voicecall event, status: 0, id: 2, number: <phone-number-2>
>> called_number: , called_name
>> ofonod[14366]: src/voicecall.c:ofono_voicecall_notify() Found call with
>> id: 2
>>
>
> Regards,
> -Denis
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============2218124713504976059==--

