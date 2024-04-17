Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF152C69A
	for <ofono@lists.linux.dev>; Wed, 17 Apr 2024 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386330; cv=none; b=fnbPLFCPLLtO/m0R92F3bdV0/ll2ZZCszN5qnVSQ9fUi2bkjTyrAFgdYqVqA2q9C25p/iiidroEZWUQ5Dv7VxnZXVx3cf1FJ1cdrSRW1k4+9p/0L9EqSL6hvr0oPXDj6OAOKH/YFF9rsXuk1LcTB35ChwMK5LtV9GXCf+mysvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386330; c=relaxed/simple;
	bh=gRus1O0UO4URWWCmRVkfDITXAMrhY42HIo9i1hdA57E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpjJuqg3u97Hl933KqArVlOJ/mUwvy/vqzsWKmN72XrpMErY/Nd7H9nCPVHxFsTdfamFl+I0CtT17pWP1Y/o0jDzwtvKIE0Ast9KyiKTrxsm2j/0oRycFWH64XCr5cs/BSVnlOlTdkGI834qSXCt06czYLB3Hc8T0hpIP/QFZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqKMzGCI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqKMzGCI"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3481bb34e7dso48950f8f.3
        for <ofono@lists.linux.dev>; Wed, 17 Apr 2024 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713386327; x=1713991127; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVN48PoawnVg5khqfzGn9Sx3cvmpDhmgUqcgV6GEIT4=;
        b=jqKMzGCI6OUGq44fvdYzlPo0KYqOJfiFq6e7mrFytTnJs4GE3WwSiRkTURGbvBxAqZ
         9zRVta/rse7XxhVo60njQ6YoHDHZB6D35p2XjVyfdTJM43eEK4rBxCR4ADcH3fySWVS4
         ymALHUp5Y8kbkKmYl8Fifl5sU/E+TCNghHXB4lIxoCIhr4kxOyOAGcDVlBBNopSz6JTI
         FqcVzso/UFPijTX2sOZta1WwWAhIyS1DKMcKV3EKeJFjlbnVaFjr8zxTAawe8tgfnw+8
         H6YNbv/J4mOZ9L4aikxEvyQlQJt+MaWtTj3X2Ivi2/717PnozoAyL3gXRiTx6J8Icesi
         VDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713386327; x=1713991127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVN48PoawnVg5khqfzGn9Sx3cvmpDhmgUqcgV6GEIT4=;
        b=g1gE8kmOtofcGwB9ix2jj6b9IuEJ+Q6DI40t2VPWTi+J0uwl9Lt8GjH2dafyOQ17SO
         +zUkEq+P0g9VQoyT5RYqKf+fW54ArkiJoKa+Y5UDjlc5bkMIXhqQmut2sckbhNyoWPfM
         wrCRPe9FwaXagzMZvQcyO1Tf6PRgNI3ZtD1fMBObOp7NrRafJiAsla1FevXP020g7iOr
         ATcMO2iyKFr68IRGZoi/VER0JXkpUwAYiZBFX71z8vLi9Ote4Q8CMISl6MNr2mjuRd60
         qnl5Ip2ZEfUtRnMHU6YiTzkQZarLzc9UJMj8uWUnd8Gs75qpb66HOoGDo1D+tcQDjcva
         8nVA==
X-Gm-Message-State: AOJu0Yyi5RlI2MieDZiwxsoLEz3Y0eLhd54O6tA+TA/qRp/iqdK+f8/U
	eJZaRghoAGl+fhTEYWmQuYVmubnNjKLUC4EcUMhsZVUW0xC5XTn66jDmLg==
X-Google-Smtp-Source: AGHT+IFHEr41Q16Qv0HcgZe+Grk8279h3CuMXbuSctxXHOgkSMRkkBRfEK6K4+xlnlLaNII4gcyPbA==
X-Received: by 2002:a05:6000:1841:b0:343:70bc:4578 with SMTP id c1-20020a056000184100b0034370bc4578mr260692wri.70.1713386326656;
        Wed, 17 Apr 2024 13:38:46 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.246.103.111])
        by smtp.gmail.com with ESMTPSA id p13-20020adfe60d000000b00349b73143e7sm38641wrm.75.2024.04.17.13.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:38:46 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/4] qmimodem: voicecall: Implement call dialing
Date: Wed, 17 Apr 2024 21:38:40 +0100
Message-ID: <2693964.vuYhMxLoTh@adam-laptop-hp>
In-Reply-To: <e17d9cdb-03ee-4f1e-b2d4-1a5c02040777@gmail.com>
References:
 <20240413215318.12236-1-adam@piggz.co.uk>
 <e17d9cdb-03ee-4f1e-b2d4-1a5c02040777@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday 16 April 2024 19:16:01 BST Denis Kenzior wrote:
> Hi Adam,
> 
> So this is looking really close now, I think we're getting almost to the
> finish line :)
> 
> On 4/13/24 16:53, Adam Pigg wrote:
> > Add voicecall dialling to the qmimodem driver
> 
> "dialling -> dialing"?
> 
> > Includes required infratructure and setup of the QMI services
> 
> "infratructure" -> "infrastructure"?
> 
> > Call State Handling
> > ===================
> > On initialisation, register the all_call_status_ind callback to be
> > called for QMI_VOICE_IND_ALL_STATUS.  This will handle notificatiof of
> 
> notificatiof -> notification
> 
> > call status to the rest of the system
> > 
> > Dial Handling
> > =============
> > The dial function sets up the parameters for the QMI_VOICE_DIAL_CALL
> > service.  The parameters are the number to be called and the call type,
> > which is currently hard coded to be QMI_VOICE_CALL_TYPE_VOICE.  The
> > dial_cb callback wi then be called and will receive the call-id.
> 
> "wi" -> will
> 
> > ---
> > Changes in V4
> > -merged qmi_voice_call_status and all_call_status_ind
> > -several minor structure/formate changes
> > ---
> > ---
> > 
> >   drivers/qmimodem/voice.h     |  17 ++
> >   drivers/qmimodem/voicecall.c | 435 ++++++++++++++++++++++++++++++++++-
> >   2 files changed, 451 insertions(+), 1 deletion(-)
> 
> <snip>
> 
> > +static int ofono_call_compare(const void *a, const void *b, void *data)
> > +{
> > +	const struct ofono_call *ca = a;
> > +	const struct ofono_call *cb = b;
> > +
> > +	if (ca->id < cb->id)
> > +		return -1;
> > +
> > +	if (ca->id > cb->id)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static bool ofono_call_compare_by_id(const void *a, const void *b)
> 
> nit: it is a bit confusing to have two functions which both have
> 'ofono_call_compare' prefix.  I like to name l_queue_match_func_t functions
> with 'match' in the name.  Perhaps this one can be called
> ofono_call_id_matches or ofono_call_match_by_id?
> 
> > +{
> > +	const struct ofono_call *call = a;
> > +	unsigned int id = L_PTR_TO_UINT(b);
> > +
> > +	return (call->id == id);
> > +}
> > +
> 
> <snip>
> 
> > +static void ofono_call_list_notify(struct ofono_voicecall *vc,
> > +					struct l_queue *calls)
> > +{
> > +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> > +	struct l_queue *old_calls = vd->call_list;
> > +	struct l_queue *new_calls = calls;
> > +	struct ofono_call *new_call, *old_call;
> > +	const struct l_queue_entry *old_entry, *new_entry;
> > +	uint i;
> > +
> > +	uint loop_length =
> > +		MAX(l_queue_length(old_calls), 
l_queue_length(new_calls));
> > +
> > +	old_entry = l_queue_get_entries(old_calls);
> > +	new_entry = l_queue_get_entries(new_calls);
> > +
> > +	for (i = 0; i < loop_length; ++i) {
> > +		old_call = old_entry ? old_entry->data : NULL;
> > +		new_call = new_entry ? new_entry->data : NULL;
> > +
> > +		if (new_call && new_call->status == 
CALL_STATUS_DISCONNECTED) {
> > +			ofono_voicecall_disconnected(
> > +				vc, new_call->id,
> > +				
OFONO_DISCONNECT_REASON_REMOTE_HANGUP, NULL);
> > +
> 
> You need to update new_entry here to point to the next entry, otherwise
> you'll have a use-after-free condition when there are multiple calls. 
> Something like: new_entry = new_entry->next;
> 
> > +			l_queue_remove(calls, new_call);
> 
> Remember, l_queue is just a singly linked list with a tail pointer.  So
> l_queue_remove would be freeing new_entry underneath.
> 
> > +			l_free(new_call);
> > +			continue;
> > +		}
> > +
> > +		if (old_call &&
> > +		    (new_call == NULL || (new_call->id > old_call-
>id)))
> 
> Looks like an indentation problem here still.  Using !new_call would make it
> fit: if (old_call && (!new_call || (new_call->id > old_call->id)))
> > +			ofono_voicecall_disconnected(
> > +				vc, old_call->id,
> > +				
OFONO_DISCONNECT_REASON_REMOTE_HANGUP, NULL);
> > +		else if (new_call &&
> > +			 (old_call == NULL || (new_call->id < 
old_call->id))) {
> 
> indentation problem here too.
> 
> > +			DBG("Notify new call %d", new_call->id);
> > +			/* new call, signal it */
> > +			if (new_call->type == 0)
> > +				ofono_voicecall_notify(vc, 
new_call);
> > +		} else if (memcmp(new_call, old_call, 
sizeof(*new_call)) &&
> > +				new_call->type == 0)
> > +			ofono_voicecall_notify(vc, new_call);
> > +
> > +		if (old_entry)
> > +			old_entry = old_entry->next;
> > +		if (new_entry)
> > +			new_entry = new_entry->next;
> > +	}
> > +
> > +	l_queue_destroy(old_calls, l_free);
> > +	vd->call_list = calls;
> > +}
> > +
> 
> <snip>
> 
> > +
> > +static void all_call_status_ind(struct qmi_result *result, void
> > *user_data) +{
> > +	struct ofono_voicecall *vc = user_data;
> > +
> > +	int i;
> > +	int offset;
> > +	uint16_t len;
> > +	bool status = true;
> > +	int instance_size;
> > +	const struct qmi_voice_call_information *call_information;
> > +	const struct qmi_voice_remote_party_number *remote_party_number;
> > +	const struct qmi_voice_remote_party_number_instance
> > *remote_party_number_inst[16]; +	struct l_queue *calls = l_queue_new();
> > +
> > +	static const uint8_t QMI_VOICE_ALL_CALL_STATUS_CALL_INFORMATION = 
0x01;
> > +	static const uint8_t QMI_VOICE_ALL_CALL_STATUS_REMOTE_NUMBER = 
0x10;
> > +	static const uint8_t QMI_VOICE_ALL_CALL_INFO_CALL_INFORMATION = 
0x10;
> > +	static const uint8_t QMI_VOICE_ALL_CALL_INFO_REMOTE_NUMBER = 0x11;
> 
> Please change the name to RESULT_CALL_STATUS_* and RESULT_CALL_INFO_*
> 
> > +
> > +	DBG("");
> > +
> > +	/* mandatory */
> > +	call_information = qmi_result_get(
> > +		result, QMI_VOICE_ALL_CALL_STATUS_CALL_INFORMATION, 
&len);
> > +
> > +	if (!call_information) {
> > +		call_information = qmi_result_get(
> > +			result, 
QMI_VOICE_ALL_CALL_INFO_CALL_INFORMATION,
> > +			&len);
> > +		status = false;
> > +	}
> > +
> > +	if (!call_information || len < sizeof(call_information->size)) {
> > +		DBG("Parsing of all call status indication failed");
> > +		goto error;
> > +	}
> > +
> > +	if (!call_information->size) {
> > +		DBG("No call informations received!");
> > +		goto error;
> > +	}
> > +
> > +	if (len != call_information->size *
> > +			sizeof(struct 
qmi_voice_call_information_instance) +
> > +			sizeof(call_information->size)) {
> > +		DBG("Call information size incorrect");
> > +		goto error;
> > +	}
> 
> You could choose to allocate the calls l_queue only after these basic checks
> are done and replace all the gotos above with return statements.
> 
> > +
> > +
> 
> Nit: No double-empty lines please
> 
> > +	/* mandatory */
> > +	remote_party_number = qmi_result_get(
> > +		result,
> > +		status ? QMI_VOICE_ALL_CALL_STATUS_REMOTE_NUMBER :
> > +			 QMI_VOICE_ALL_CALL_INFO_REMOTE_NUMBER,
> > +		&len);
> > +
> > +	if (!remote_party_number) {
> > +		DBG("Unable to retrieve remote numbers");
> > +		goto error;
> > +	}
> > +
> > +	/* verify the length */
> > +	if (len < sizeof(remote_party_number->size)) {
> > +		DBG("Parsing of remote numbers failed");
> > +		goto error;
> > +	}
> > +
> > +	/* expect we have valid fields for every call */
> > +	if (call_information->size != remote_party_number->size) {
> > +		DBG("Not all fields have the same size");
> > +		goto error;
> > +	}
> 
> Same here, if l_queue was allocated later, these could be return statements.
> > +
> > +	/* pull the remote call info into a local array */
> > +	instance_size = sizeof(struct 
qmi_voice_remote_party_number_instance);
> > +
> > +	for (i = 0, offset = sizeof(remote_party_number->size);
> > +			offset <= len && i < 16 && i < 
remote_party_number->size;
> > +			i++) {
> > +		const struct qmi_voice_remote_party_number_instance 
*instance;
> > +
> > +		if (offset == len)
> > +			break;
> 
> Hmm, would changing the condition in the for loop to 'offset < len' make
> this if statement redundant?
> 
> > +
> > +		if (offset + instance_size > len) {
> > +			DBG("Error parsing remote numbers");
> > +			goto error;
> > +		}
> > +
> > +		instance = (void *)remote_party_number + offset;
> > +		if (offset + instance_size + instance->number_size > 
len) {
> > +			DBG("Error parsing remote numbers");
> > +			goto error;
> > +		}
> 
> Empty line here please, doc/coding-style.txt item M1
> 
> > +		remote_party_number_inst[i] = instance;
> > +		offset +=
> > +			sizeof(struct 
qmi_voice_remote_party_number_instance) +
> > +			instance->number_size;
> > +	}
> 
> The goto statements in the above for {} block could also be switched to
> returns if the queue was allocated here.
> 
> > +
> > +	for (i = 0; i < call_information->size; i++) {
> 
> In the for loop above you have an additional bound for i < 16, but here you
> don't have this.
> 
> > +		struct ofono_call *call = l_new(struct ofono_call, 1);
> > +		struct qmi_voice_call_information_instance call_info;
> > +		const struct qmi_voice_remote_party_number_instance
> > +			*remote_party = remote_party_number_inst[i];
> 
> This could lead to an out-of-bounds access here.
> 
> > +		int number_size;
> > +
> > +		call_info = call_information->instance[i];
> > +
> > +		call->id = call_info.id;
> > +		call->direction = 
qmi_to_ofono_direction(call_info.direction);
> > +		call->type = 0; /* always voice */
> > +
> > +		number_size = remote_party->number_size + 1;
> 
> Why +1?  We can't copy more than remote_party->number_size bytes from
> remote_party->number, otherwise we read out of bounds ?
In my testing I found that the last digit of the number was being missed.  
This fixed it, though I suspected it may come back to haunt me!  Any 
suggestions?
> 
> > +		if (number_size > OFONO_MAX_PHONE_NUMBER_LENGTH)
> > +			number_size = OFONO_MAX_PHONE_NUMBER_LENGTH;
> > +
> > +		l_strlcpy(call->phone_number.number, remote_party-
>number,
> > +				number_size);
> > +
> > +		if (strlen(call->phone_number.number) > 0)
> > +			call->clip_validity = 0;
> > +		else
> > +			call->clip_validity = 2;
> > +
> > +		if (qmi_to_ofono_status(call_info.state, &call-
>status)) {
> > +			DBG("Ignore call id %d, because can not 
convert QMI state 0x%x to
> > ofono.", +				call_info.id, 
call_info.state);
> > +			l_free(call);
> > +			continue;
> > +		}
> 
> empty line please, item M1
> 
> > +		DBG("Call %d in state %s(%d)", call_info.id,
> > +			qmi_voice_call_state_name(call_info.state),
> > +			call_info.state);
> > +
> > +		l_queue_push_tail(calls, call);
> > +	}
> > +
> > +	ofono_call_list_notify(vc, calls);
> > +
> > +	return;
> > +error:
> > +	l_queue_destroy(calls, l_free);
> > +}
> > +
> > +static void dial_cb(struct qmi_result *result, void *user_data)
> > +{
> > +	struct cb_data *cbd = user_data;
> > +	struct ofono_voicecall *vc = cbd->user;
> > +	ofono_voicecall_cb_t cb = cbd->cb;
> > +	uint16_t error;
> > +	uint8_t call_id;
> > +
> > +	static const uint8_t QMI_VOICE_DIAL_RESULT_CALL_ID = 0x10;
> 
> Name this to RESULT_CALL_ID to be consistent with how this is done elsewhere
> > +
> > +	DBG("");
> > +
> > +	if (qmi_result_set_error(result, &error)) {
> > +		DBG("QMI Error %d", error);
> > +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> > +		return;
> > +	}
> > +
> > +	if (!qmi_result_get_uint8(result, QMI_VOICE_DIAL_RESULT_CALL_ID,
> > +			&call_id)) {
> > +		ofono_error("No call id in dial result");
> > +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> > +		return;
> > +	}
> > +
> > +	DBG("New call QMI id %d", call_id);
> > +	ofono_call_list_dial_callback(vc, call_id);
> > +
> > +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> > +}
> > +
> > +static void dial(struct ofono_voicecall *vc,
> > +			const struct ofono_phone_number *ph,
> > +			enum ofono_clir_option clir, 
ofono_voicecall_cb_t cb,
> > +			void *data)
> > +{
> > +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> > +	struct cb_data *cbd = cb_data_new(cb, data);
> > +	struct qmi_param *param;
> > +	const char *calling_number = phone_number_to_string(ph);
> > +
> > +	static const uint8_t QMI_VOICE_DIAL_CALL_NUMBER = 0x01;
> > +	static const uint8_t QMI_VOICE_DIAL_CALL_TYPE = 0x10;
> 
> Name these two PARAM_CALL_NUMBER and PARAM_CALL_TYPE
> 
> > +	static const uint8_t QMI_VOICE_CALL_TYPE_VOICE = 0x00;
> > +
> > +	DBG("");
> > +
> > +	cbd->user = vc;
> > +	memcpy(&vd->dialed, ph, sizeof(*ph));
> > +
> > +	param = qmi_param_new();
> > +	if (!param)
> > +		goto error;
> 
> qmi_param_new can't fail, this if can be removed
> 
> > +
> > +	if (!qmi_param_append(param, QMI_VOICE_DIAL_CALL_NUMBER,
> > +			strlen(calling_number), calling_number))
> > +		goto error;
> > +
> > +	qmi_param_append_uint8(param, QMI_VOICE_DIAL_CALL_TYPE,
> > +				QMI_VOICE_CALL_TYPE_VOICE);
> > +
> > +	if (qmi_service_send(vd->voice, QMI_VOICE_DIAL_CALL, param, 
dial_cb,
> > +				cbd, l_free) > 0)
> > +		return;
> > +
> > +error:
> > +	CALLBACK_WITH_FAILURE(cb, data);
> > +	l_free(cbd);
> > +	l_free(param);
> > +}
> > +
> > 
> >   static void create_voice_cb(struct qmi_service *service, void
> >   *user_data)
> >   {
> >   
> >   	struct ofono_voicecall *vc = user_data;
> 
> <snip>
> 
> Regards,
> -Denis




