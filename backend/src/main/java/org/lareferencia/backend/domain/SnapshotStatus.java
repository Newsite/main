package org.lareferencia.backend.domain;

public enum SnapshotStatus {
	
	INITIALIZED,
	HARVESTING,
	RETRYING,
	HARVESTING_FINISHED_ERROR,
	HARVESTING_FINISHED_VALID,
	HARVESTING_STOPPED,
	INDEXING,
	INDEXING_FINISHED_ERROR,
	INDEXING_FINISHED_VALID,
	VALID
}

