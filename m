Content-Type: multipart/mixed; boundary="===============9194965102273692707=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC PATCH 1/3] call-barring: removed +CSSI type SS notifications
Date: Thu, 10 Feb 2011 10:43:14 +0200
Message-ID: <4D53A522.1040407@nokia.com>
In-Reply-To: <4D5355D6.9000503@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9194965102273692707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 02/10/2011 05:04 AM, ext Denis Kenzior wrote:
> Hi Andras
>
> On 02/09/2011 04:33 AM, Andras Domokos wrote:
>> ---
>>   src/call-barring.c |   74 --------------------------------------------=
--------
>>   1 files changed, 0 insertions(+), 74 deletions(-)
>>
>> diff --git a/src/call-barring.c b/src/call-barring.c
>> index 649826e..84ed277 100644
>> --- a/src/call-barring.c
>> +++ b/src/call-barring.c
>> @@ -58,9 +58,6 @@ struct ofono_call_barring {
>>   	int ss_req_lock;
>>   	struct ofono_ssn *ssn;
> You forgot to remove this part in your patch.  I applied your patch and
> fixed this in a follow on patch.
Indeed I did. Thanks a lot for the fix!
>>   	struct ofono_ussd *ussd;
>> -	unsigned int incoming_bar_watch;
>> -	unsigned int outgoing_bar_watch;
>> -	unsigned int ssn_watch;
>>   	unsigned int ussd_watch;
>>   	const struct ofono_call_barring_driver *driver;
>>   	void *driver_data;
> Regards,
> -Denis
Regards,
Andras

--===============9194965102273692707==--

