Content-Type: multipart/mixed; boundary="===============6831494423040156641=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] stk: Handle set up call in handled_notify
Date: Fri, 15 Jul 2011 11:11:44 -0500
Message-ID: <4E2066C0.6040403@gmail.com>
In-Reply-To: <65215.10.254.189.70.1310733972.squirrel@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6831494423040156641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 07/15/2011 07:46 AM, jeevaka.badrappan(a)linux.intel.com wrote:
> Hi,
> =

>> @@ -529,7 +531,12 @@ static void stk_alpha_id_set(struct ofono_stk *stk,
>>
>>  static void stk_alpha_id_unset(struct ofono_stk *stk)
>>  {
>> -	stk_agent_request_cancel(stk->current_agent);
>> +	/*
>> +	 * If there is no default agent, then current agent also will be NULL.
>> +	 * So, call request cancel only when there is a valid current agent.
>> +	 */
>> +	if (stk->current_agent)
>> +		stk_agent_request_cancel(stk->current_agent);
>>  }
>>
> =

> If needed, I can send this code change alone in a separate fix patch.
> =


It sounds like you were getting a crash with this one, so please send it
as a separate patch.

Regards,
-Denis

--===============6831494423040156641==--

