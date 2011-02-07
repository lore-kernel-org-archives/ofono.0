Content-Type: multipart/mixed; boundary="===============3976349302913804453=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC] voicecall API changes (proposal v3)
Date: Mon, 07 Feb 2011 19:07:09 +0200
Message-ID: <4D5026BD.7060205@nokia.com>
In-Reply-To: <4D502012.4050704@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3976349302913804453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 02/07/2011 06:38 PM, ext Denis Kenzior wrote:
> Hi Andras,
>
>> +		CallForwarded(string type)
>> +
>> +			Signal emitted when an outgoing voice call is made and
>> +			the call has been redirected to another number due to
>> +			the remote party's "Call Forwarding" Supplementary
>> +			Services settings. In this case the type parameter in
>> +			the signal is set to "outgoing".
> You do not want to distinguish between conditional / unconditional?
> Just checking here, either one is fine with me.
In the end I made a simplification and I merged the conditional and
unconditional cases.
>> +			The signal is also emitted when the incoming voice call
>> +			is a redirected call due to a call forwarding operation.
>> +			In this case the type parameter in the signal is set to
>> +			"incoming".
>> +
>> +
>>   Properties	array{string} EmergencyNumbers [readonly]
>>
>>   			Contains the list of emergency numbers recognized
> The proposal looks good to me.  I'd apply it, however git am complains:
>
> Applying: voicecall API changes (proposal v3)
> /home/denkenz/ofono-master/.git/rebase-apply/patch:32: new blank line at
> EOF.
> +
> fatal: 1 line adds whitespace errors.
My mistake, there is an extra empty line there, I will redo the patch.
> Regards,
> -Denis
Regards,
Andras

--===============3976349302913804453==--

