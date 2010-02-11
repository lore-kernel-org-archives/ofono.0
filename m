Content-Type: multipart/mixed; boundary="===============8984529591336534099=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: [PATCH 1/4] Add write ring buffer for non-blocking write
Date: Thu, 11 Feb 2010 09:40:33 +0800
Message-ID: <4B736011.90805@intel.com>
In-Reply-To: <20100210172337.GC6797@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8984529591336534099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Padovan,

On 02/11/2010 01:23 AM, Gustavo F. Padovan wrote:
> * Zhenhua Zhang<zhenhua.zhang@intel.com>  [2010-02-10 16:13:40 +0800]:
>> +
>> +	for (i =3D 0; i<  MAX_BUFFER_NUM; i++) {
>> +#ifdef WRITE_SCHEDULER_DEBUG
>> +		buf =3D ring_buffer_new(4);
>> +#else
>> +		buf =3D ring_buffer_new(4096);
>> +#endif
>
> Why not a macro to define buf size? So you don't need to use ifdef
> everytime
>
> #ifdef WRITE_SCHEDULER_DEBUG
> 		BUF_SIZE =3D 4
> #else
> 		BUF_SIZE =3D 4096	=

> #endif

Good suggestion. We can use a macro to define the buffer size.

>> +		if (!buf)
>> +			return FALSE;
>> +
>> +		server->free_list =3D g_slist_prepend(server->free_list, buf);
>> +	}
>> +
>> +	return TRUE;
>> +}
>> +
>> +static void free_ring_buffer(struct ring_buffer *buf)
>> +{
>> +	ring_buffer_free(buf);
>> +}
>
> This seems pointless to me.

It just remind me to call ring_buffer_free. Yes. I can remove it and =

call ring_buffer_free in g_slist_foreach() directly.

>> +
>>   static void g_at_server_cleanup(GAtServer *server)
>>   {
>>   	/* Cleanup all received data */
>>   	ring_buffer_free(server->read_buf);
>>   	server->read_buf =3D NULL;
>>
>> +	/* Cleanup pending data to write */
>> +	ring_buffer_free(server->write_buf);
>> +	server->write_buf =3D NULL;
>> +
>> +	if (server->full_list)
>> +		g_slist_foreach(server->full_list, (GFunc)free_ring_buffer,
>> +					NULL);
>> +
>> +	if (server->free_list)
>> +		g_slist_foreach(server->free_list, (GFunc)free_ring_buffer,
>> +					NULL);
>> +
>>   	server->channel =3D NULL;
>>   }
>>
>> @@ -446,8 +507,6 @@ static void read_watcher_destroy_notify(GAtServer *s=
erver)
>>   	g_at_server_cleanup(server);
>>   	server->read_watch =3D 0;
>>
>> -	server->channel =3D NULL;
>> -
>>   	if (server->user_disconnect)
>>   		server->user_disconnect(server->user_disconnect_data);
>>
>> @@ -455,6 +514,23 @@ static void read_watcher_destroy_notify(GAtServer *=
server)
>>   		g_free(server);
>>   }
>>
>> +static void write_watcher_destroy_notify(GAtServer *server)
>> +{
>> +	server->write_watch =3D 0;
>> +}
>> +
>> +static void g_at_server_wakeup_writer(GAtServer *server)
>> +{
>> +	if (server->write_watch !=3D 0)
>> +		return;
>> +
>> +	server->write_watch =3D g_io_add_watch_full(server->channel,
>> +			G_PRIORITY_DEFAULT,
>> +			G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
>> +			can_write_data, server,
>> +			(GDestroyNotify)write_watcher_destroy_notify);
>> +}
>> +
>>   static void v250_settings_create(struct v250_settings *v250)
>>   {
>>   	v250->s3 =3D '\r';
>> @@ -483,11 +559,22 @@ GAtServer *g_at_server_new(GIOChannel *io)
>>   	v250_settings_create(&server->v250);
>>   	server->channel =3D io;
>>   	server->read_buf =3D ring_buffer_new(4096);
>> -	server->max_read_attempts =3D 3;
>> -
>>   	if (!server->read_buf)
>>   		goto error;
>>
>> +#ifdef WRITE_SCHEDULER_DEBUG
>> +	server->write_buf =3D ring_buffer_new(4);
>> +#else
>> +	server->write_buf =3D ring_buffer_new(4096);
>> +#endif
>> +	if (!server->write_buf)
>> +		goto error;
>> +
>> +	if (!alloc_free_list(server))
>> +		goto error;
>> +
>> +	server->max_read_attempts =3D 3;
>> +
>>   	if (!g_at_util_setup_io(server->channel, G_IO_FLAG_NONBLOCK))
>>   		goto error;
>>
>> @@ -502,6 +589,13 @@ error:
>>   	if (server->read_buf)
>>   		ring_buffer_free(server->read_buf);
>>
>> +	if (server->write_buf)
>> +		ring_buffer_free(server->write_buf);
>> +
>> +	if (server->free_list)
>> +		g_slist_foreach(server->free_list, (GFunc)free_ring_buffer,
>> +					NULL);
>> +
>>   	if (server)
>>   		g_free(server);
>>
>> @@ -552,6 +646,9 @@ gboolean g_at_server_shutdown(GAtServer *server)
>>   	server->user_disconnect =3D NULL;
>>   	server->user_disconnect_data =3D NULL;
>>
>> +	if (server->write_watch)
>> +		g_source_remove(server->write_watch);
>> +
>>   	if (server->read_watch)
>>   		g_source_remove(server->read_watch);
>>
>> --
>> 1.6.6.1
>>
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> http://lists.ofono.org/listinfo/ofono
>


--===============8984529591336534099==--

