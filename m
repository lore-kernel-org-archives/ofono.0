Content-Type: multipart/mixed; boundary="===============0514472977530937472=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 1/5] Refactor the command parsing framework
Date: Fri, 26 Mar 2010 07:37:45 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351D67BF96@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201003251224.31500.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0514472977530937472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

>> ---
>>  gatchat/gatserver.c |  182
>>  +++++++++++++++++++++++++++++++++++---------------
>>  gatchat/gatserver.h |   7 ++- 2 files changed, 133 insertions(+),
>> 56 deletions(-) =

>> =

>> -	at_command_notify(server, buf, prefix, type);
>> +	notify =3D at_node_new(server, buf, prefix, type);
>> +	if (!notify)
>> +		goto error;
>> =

>>  	/* Also consume the terminating null */
>> -	return i + 1;
>> +	server->read_pos +=3D i + 1;
>> +	server->notify_source =3D g_idle_add_full(G_PRIORITY_DEFAULT,
>> +						at_command_notify, +						notify, g_free);
>> +
>> +	return;
>> +
>> +error:
>> +	g_free(notify);
>> +
>> +	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
>>  }
> =

> Err, OK stop right there.  This is really way too complicated.
> How about we simply set a flag before calling
> at_command_notify.  If after executing it send_final or
> send_ext_final response has been sent, then we continue
> processing, otherwise we restart when send_ext_final or
> send_final will be called again.  You really don't need to touch this
> function at all. =


OK. So the problem is if the at_command_notify is blocked by user callback,=
 the mainloop won't have chance to read data in from non-blocking I/O I gue=
ss. That's the reason I added this. If we don't need to handle such case, t=
hen the logic could be much simplier. We could discuss it on IRC.

>> +typedef void (*GAtServerNotifyCallback)(gpointer user_data);
>> +
> =

> Get rid of this, not necessary.
> =

>>  typedef void (*GAtServerNotifyFunc)(GAtServerRequestType type,
>> -					GAtResult *result,
> gpointer user_data);
>> +					GAtResult *result,
>> +					gpointer user_data,
>> +					GAtServerNotifyCallback cb,
>> +					gpointer cb_data);
>> =

> =

> Keep the NotifyFunc the way it is, your changes are really not
> required. =

> =

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============0514472977530937472==--

