package main.model;
import javax.persistence.*;

@Entity
@Table(name = "parameter")
//@SequenceGenerator(name = "mapseq2", sequenceName="mapseq",allocationSize=50)
public class Parameter {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)

	@Column(name="parameter_id", updatable=false, nullable=false)
	private Long parameter_id;
	
	@Column(name = "nameParametr")
	private String nameParametr;
	
	@Column(name = "stepParametr")
	private Double step;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "mapTable_id")
	private MapTable mapTable;
	
	public Parameter() {
	}
	public void setItem(MapTable mapTable)
	{
		if (this.mapTable != null)
		this.mapTable.internalRemoveParametr(this);
		this.mapTable = mapTable;
		if (mapTable != null)
		mapTable.internalAddParametr(this);
	}

	public Long getParameter_id() {
		return parameter_id;
	}

	public void setParameter_id(Long parameter_id) {
		this.parameter_id = parameter_id;
	}

	public String getNameParametr() {
		return nameParametr;
	}

	public void setNameParametr(String nameParametr) {
		this.nameParametr = nameParametr;
	}

	public Double getStep() {
		return step;
	}

	public void setStep(Double step) {
		this.step = step;
	}

	public MapTable getMapTable() {
		return mapTable;
	}

	public void setMapTable(MapTable mapTable) {
		this.mapTable = mapTable;
	}
}
