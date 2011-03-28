Content-Type: multipart/mixed; boundary="===============5295680860204996710=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] dun: Add ATX command in emulator (X0 only)
Date: Mon, 28 Mar 2011 11:20:07 -0500
Message-ID: <4D90B537.2050401@gmail.com>
In-Reply-To: <4D903D9C.6000907@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5295680860204996710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

On 03/28/2011 02:49 AM, Olivier Guiter wrote:
> On 03/25/2011 06:36 PM, Denis Kenzior wrote:
>> Hi Olivier,
>>
>> On 03/24/2011 10:29 AM, Olivier Guiter wrote:
>>> ---
>>>   src/emulator.c |   57
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>   1 files changed, 56 insertions(+), 1 deletions(-)
>>>
>> I applied this patch, however...
>>
>> <snip>
>>
>>> +    case G_AT_SERVER_REQUEST_TYPE_QUERY:
>>> +        g_at_server_send_info(server, "000", TRUE);
>> This seems fishy to me.  Shouldn't this be X: 0?
>>
>>> +        g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
>>> +        break;
>> <snip>
>>
>> Regards,
>> -Denis
> It should be ;) but i tried to keep the answer format consistent with
> other AT command answers... Maybe i m wrong ?

What other AT command answers?

Anyhow, I've reverted this patch for now since I realized that ATX is
already implemented in gatserver.c

Regards,
-Denis

--===============5295680860204996710==--

